import 'dart:io';
import 'package:app_cursos/core/supabase_client.dart';
import 'package:app_cursos/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../user/avatar_view_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  User? get user => supabase.auth.currentUser;

  String? _avatarUrl;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    await supabase.auth.refreshSession();
    final currentUser = supabase.auth.currentUser;

    if (!mounted) return;

    setState(() {
      _avatarUrl = currentUser?.userMetadata?['avatar_url'];
    });
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    return File(image.path);
  }

  Future<String?> uploadAvatar(File image) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final fileName = '${user.id}/avatar.jpg';

      final bytes = await image.readAsBytes();

      await supabase.storage.from('avatars').uploadBinary(
        fileName,
        bytes,
        fileOptions: const FileOptions(upsert: true),
      );

      final imageUrl =
          supabase.storage.from('avatars').getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      if (!mounted) return null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar imagem: $e')),
      );

      return null;
    }
  }

  Future<void> saveAvatarUrl(String url) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            'avatar_url': url,
          },
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar avatar: $e')),
      );
    }
  }

  Future<void> changeAvatar() async {
    print("USER ID: ${supabase.auth.currentUser?.id}");

    final image = await pickImage();
    if (image == null) return;

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enviando imagem...')),
    );

    final url = await uploadAvatar(image);

    if (url != null) {
      await saveAvatarUrl(url);

      if (!mounted) return;

      setState(() {
        _avatarUrl =
            "$url?t=${DateTime.now().millisecondsSinceEpoch}";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avatar atualizado!')),
      );
    }
  }

  void _salvarPerfil() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // AVATAR + BOTÃO EDITAR
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    GestureDetector(
                      onTap: () {
                        if (_avatarUrl != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AvatarViewPage(imageUrl: _avatarUrl!),
                            ),
                          );
                        }
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: _avatarUrl != null
                            ? NetworkImage(_avatarUrl!)
                            : null,
                        child: _avatarUrl == null
                            ? const Icon(Icons.person, size: 45)
                            : null,
                      ),
                    ),

                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFF7C3AED),
                          ),
                          onPressed: changeAvatar,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                user?.userMetadata?['full_name'] ??
                    user?.email ??
                    '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              if (_isEditing) ...[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o nome' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.contains('@') ? null : 'E-mail inválido',
                ),
              ] else ...[
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.badge_outlined),
                    title: Text('Nome'),
                  ),
                ),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text('E-mail'),
                  ),
                ),
              ],

              const SizedBox(height: 24),

              if (_isEditing)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _toggleEdit,
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _salvarPerfil,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Salvar perfil'),
                      ),
                    ),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: _toggleEdit,
                ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await authService.signOut();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                      (route) => false,
                    );
                  } catch (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Erro ao sair"),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text("Sair"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}