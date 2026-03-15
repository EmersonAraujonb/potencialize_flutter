import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisar cursos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar cursos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Expanded(
              child: Center(
                child: Text('Nenhum curso encontrado'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}