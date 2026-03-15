import 'package:app_cursos/core/supabase_client.dart';
import 'package:flutter/material.dart';
import 'user_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    String? userAvatarUrl = user?.userMetadata?['avatar_url'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_sharp, size: 28),
            color: const Color.fromARGB(255, 147, 59, 247),
            tooltip: 'Conta',

            onSelected: (value) {
              if (value == 'perfil') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserPage(),
                  ),
                );
              }

              if (value == 'config') {
                print('Abrir configurações');
              }

              if (value == 'sair') {
                print('Sair da conta');
              }
            },

            itemBuilder: (context) => [

              PopupMenuItem(
                value: 'perfil',
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: userAvatarUrl != null
                          ? NetworkImage(userAvatarUrl)
                          : null,
                      child: userAvatarUrl == null
                          ? const Icon(Icons.person, size: 16)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    const Text('Perfil'),
                  ],
                ),
              ),

              const PopupMenuDivider(),

              const PopupMenuItem(
                value: 'config',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text('Configurações'),
                  ],
                ),
              ),

              const PopupMenuDivider(),

              const PopupMenuItem(
                value: 'sair',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
          )
        ],
      ),

      body: const Center(
        child: Text(
          'Bem-vindo ao Potencialize',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}