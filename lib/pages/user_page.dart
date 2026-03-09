import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _cidadeController;
  late final TextEditingController _bioController;

  bool _isEditing = false;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: 'Usuario Potencialize');
    _emailController = TextEditingController(text: 'emersonsantos@gmail.com');
    _telefoneController = TextEditingController(text: '(77) 99864-8013');
    _cidadeController = TextEditingController(text: 'Barreiras - BA');
    _bioController = TextEditingController(
      text: 'Apaixonado por tecnologia e aprendizado continuo.',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cidadeController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _escolherFoto() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Galeria'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Camera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    final foto = await _imagePicker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
    );

    if (foto == null) return;

    final bytes = await foto.readAsBytes();
    if (!mounted) return;

    setState(() {
      _avatarBytes = bytes;
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: const Color(0xFF7C3AED),
                      backgroundImage:
                          _avatarBytes != null ? MemoryImage(_avatarBytes!) : null,
                      child: _avatarBytes == null
                          ? const Icon(
                              Icons.person,
                              size: 44,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          onPressed: _escolherFoto,
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFF7C3AED),
                          ),
                          tooltip: 'Alterar foto',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _nomeController.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              if (_isEditing) ...[
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o e-mail';
                    }
                    if (!value.contains('@')) {
                      return 'E-mail invalido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cidadeController,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a cidade';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.info_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe uma bio';
                    }
                    return null;
                  },
                ),
              ] else ...[
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Nome'),
                    subtitle: Text(_nomeController.text),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('E-mail'),
                    subtitle: Text(_emailController.text),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.phone_outlined),
                    title: const Text('Telefone'),
                    subtitle: Text(_telefoneController.text),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.location_city_outlined),
                    title: const Text('Cidade'),
                    subtitle: Text(_cidadeController.text),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Bio'),
                    subtitle: Text(_bioController.text),
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
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: _salvarPerfil,
                          icon: const Icon(Icons.save_outlined),
                          label: const Text('Salvar perfil'),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Toque no icone de lapis para editar',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    IconButton(
                      onPressed: _toggleEdit,
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Editar dados',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
