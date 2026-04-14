import 'package:app_cursos/core/supabase_client.dart';
import 'package:app_cursos/main.dart';
import 'package:app_cursos/pages/user_page.dart';
import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final profileService = ProfileService();

  String name = '';
  String? _avatarUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
  final profile = await profileService.getProfile();

  await supabase.auth.refreshSession();
  final currentUser = supabase.auth.currentUser;

  if (!mounted) return;

  setState(() {
    name = profile['name'] ?? '';

    _avatarUrl = currentUser?.userMetadata?['avatar_url']
        ?? profile['avatar_url'];

    isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // 👤 PERFIL
          Card(
            child: ListTile( 
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey[200],
                backgroundImage: (_avatarUrl != null && _avatarUrl!.isNotEmpty)
                ? NetworkImage('${_avatarUrl!}?t=${DateTime.now().millisecondsSinceEpoch}')
                : null,
              ),

              title: Text(name.isNotEmpty ? name : "Usuário"),
              subtitle: const Text("Ver perfil"),

              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                // Navegar para a página de perfil
              Navigator.push( context, MaterialPageRoute( builder: (_) => const UserPage(), ), );
              },
            ),
          ),

          const SizedBox(height: 20),

          // 🌙 TEMA (exemplo)
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            title: const Text("Modo escuro"),
            onChanged: (value) {
              MyApp.of(context).toggleTheme(value);
            },
          ),
        ],
      ),
    );
  }
}