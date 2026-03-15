import 'package:app_cursos/main.dart';
import 'package:flutter/material.dart';
import 'package:app_cursos/core/supabase_client.dart';
import 'user_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final user = supabase.auth.currentUser;
    final avatarUrl = user?.userMetadata?['avatar_url'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // PERFIL DO USUÁRIO
          Card(
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundImage:
                    avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null
                    ? const Icon(Icons.person)
                    : null,
              ),

              title: Text(
                user?.userMetadata?['full_name'] ??
                user?.email ??
                "Usuário",
              ),

              subtitle: Text(
                user?.email ?? "",
              ),

              trailing: const Icon(Icons.arrow_forward_ios, size: 18),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UserPage(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // OPÇÕES
          const Text(
            "Preferências",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: Column(
              children: [

                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("Tema escuro"),
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (value) {
                      MyApp.of(context).toggleTheme(value);
                    },
                  )
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notificações"),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text("Ajuda"),
                  onTap: () {},
                ),

              ],
            ),
          ),

          const SizedBox(height: 20),

          // SAIR
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Sair",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                print("Logout");
              },
            ),
          ),
        ],
      ),
    );
  }
}