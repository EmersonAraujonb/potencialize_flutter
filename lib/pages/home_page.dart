import 'package:app_cursos/core/supabase_client.dart';
import 'package:flutter/material.dart';
import 'my_courses.dart';
// import '../services/auth_service.dart';
import 'user_page.dart';
// import 'package:app_cursos/pages/login_page.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final authService = AuthService();
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

                  if(value == 'tema'){
                    print('alternar tema');
                  }

                  if (value == 'sair') {
                    print('Sair da conta');
                  }
                },

                itemBuilder: (context) => [

                  // PERFIL
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

                  // CONFIGURAÇÕES
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

                  // SAIR
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Bem-vindo ao Potencialize',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MeusCursosPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book_outlined),
                label: const Text('Meus cursos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
