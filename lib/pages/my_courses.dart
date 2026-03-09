import 'package:flutter/material.dart';

class MeusCursosPage extends StatefulWidget {
  const MeusCursosPage({super.key});

  @override
  State<MeusCursosPage> createState() => _MeusCursosPageState();
}

class _MeusCursosPageState extends State<MeusCursosPage> {
  late final List<CursoData> _cursos;

  @override
  void initState() {
    super.initState();
    _cursos = [
      const CursoData(
        titulo: 'Flutter do Zero ao Avancado',
        descricao: 'Aprenda Flutter com foco em apps reais para Android e iOS.',
        imagem: 'assets/splash_screen.png',
        progresso: 0.65,
        aulasConcluidas: '26/40 aulas',
      ),
      const CursoData(
        titulo: 'Dart para Mobile',
        descricao: 'Domine sintaxe, colecoes e boas praticas com Dart.',
        imagem: 'assets/app_icon.png',
        progresso: 0.40,
        aulasConcluidas: '12/30 aulas',
      ),
      const CursoData(
        titulo: 'UI UX para Apps',
        descricao: 'Crie interfaces claras, consistentes e faceis de usar.',
        imagem: 'assets/icon_android.png',
        progresso: 0.85,
        aulasConcluidas: '17/20 aulas',
      ),
    ];
  }

  Future<void> _abrirCurso(int index) async {
    final atualizado = await Navigator.push<CursoData>(
      context,
      MaterialPageRoute(
        builder: (_) => CursoDetalhePage(curso: _cursos[index]),
      ),
    );

    if (atualizado != null) {
      setState(() {
        _cursos[index] = atualizado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Cursos'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _cursos.length,
        itemBuilder: (context, index) {
          return _CursoCard(
            curso: _cursos[index],
            onTap: () => _abrirCurso(index),
          );
        },
      ),
    );
  }
}

class CursoData {
  final String titulo;
  final String descricao;
  final String imagem;
  final double progresso;
  final String aulasConcluidas;

  const CursoData({
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.progresso,
    required this.aulasConcluidas,
  });

  CursoData copyWith({
    String? titulo,
    String? descricao,
    String? imagem,
    double? progresso,
    String? aulasConcluidas,
  }) {
    return CursoData(
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      imagem: imagem ?? this.imagem,
      progresso: progresso ?? this.progresso,
      aulasConcluidas: aulasConcluidas ?? this.aulasConcluidas,
    );
  }
}

class _CursoCard extends StatelessWidget {
  final CursoData curso;
  final VoidCallback onTap;

  const _CursoCard({
    required this.curso,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.asset(
                curso.imagem,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curso.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    curso.descricao,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: curso.progresso),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(curso.aulasConcluidas),
                      const Spacer(),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CursoDetalhePage extends StatefulWidget {
  final CursoData curso;

  const CursoDetalhePage({super.key, required this.curso});

  @override
  State<CursoDetalhePage> createState() => _CursoDetalhePageState();
}

class _CursoDetalhePageState extends State<CursoDetalhePage> {
  late final TextEditingController _tituloController;
  late final TextEditingController _descricaoController;
  late final TextEditingController _aulasController;
  late final TextEditingController _imagemController;
  late double _progresso;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.curso.titulo);
    _descricaoController = TextEditingController(text: widget.curso.descricao);
    _aulasController = TextEditingController(text: widget.curso.aulasConcluidas);
    _imagemController = TextEditingController(text: widget.curso.imagem);
    _progresso = widget.curso.progresso;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _aulasController.dispose();
    _imagemController.dispose();
    super.dispose();
  }

  void _salvar() {
    final atualizado = widget.curso.copyWith(
      titulo: _tituloController.text.trim(),
      descricao: _descricaoController.text.trim(),
      aulasConcluidas: _aulasController.text.trim(),
      imagem: _imagemController.text.trim(),
      progresso: _progresso,
    );
    Navigator.pop(context, atualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Curso'),
        actions: [
          TextButton(
            onPressed: _salvar,
            child: const Text('Salvar'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              _imagemController.text,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Text('Imagem nao encontrada'),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Edicao do curso',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _tituloController,
            decoration: const InputDecoration(
              labelText: 'Titulo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descricaoController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Descricao',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _aulasController,
            decoration: const InputDecoration(
              labelText: 'Aulas concluidas',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _imagemController,
            decoration: const InputDecoration(
              labelText: 'Imagem (asset)',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Text('Progresso: ${(_progresso * 100).round()}%'),
          Slider(
            value: _progresso,
            min: 0,
            max: 1,
            divisions: 20,
            onChanged: (value) {
              setState(() {
                _progresso = value;
              });
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'Conteudo completo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.play_circle_outline),
            title: Text('Modulo 1 - Introducao'),
            subtitle: Text('Configuracao do ambiente e primeiros widgets'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.play_circle_outline),
            title: Text('Modulo 2 - Layouts'),
            subtitle: Text('Column, Row, Stack e responsividade'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.play_circle_outline),
            title: Text('Modulo 3 - Estado e Navegacao'),
            subtitle: Text('Gerenciamento de estado e rotas'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Salvar card'),
            ),
          ),
        ],
      ),
    );
  }
}
