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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserPage(),
                ),
              );
            },
            icon: CircleAvatar(
              radius: 14,
              backgroundImage: userAvatarUrl != null
                  ? NetworkImage(userAvatarUrl)
                  : null,
              child: userAvatarUrl == null
                  ? const Icon(Icons.person, size: 18)
                  : null,
            ),
            tooltip: 'Usuário',
          ),
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
