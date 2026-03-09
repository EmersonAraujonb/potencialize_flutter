import 'package:flutter/material.dart';
import 'my_courses.dart';
import '../services/auth_service.dart';
import 'user_page.dart';
import 'package:app_cursos/pages/login_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await authService.signOut();

                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              } catch (e) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Erro ao sair"),
                  ),
                );
              }
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserPage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
            tooltip: 'Usuario',
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
