import 'package:app_cursos/pages/login_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const String _appVersion = "1.0.0+1";

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  void register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cadastro realizado com sucesso!"),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: const Text("Criar Conta")),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "Versão $_appVersion",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // Adiciona a decoraÃ§Ã£o com o gradiente
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Define o inÃ­cio e o fim do gradiente
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Lista de cores para o gradiente (mÃ­nimo de duas)
            colors: [
              Color.fromARGB(255, 152, 4, 250), // Uma cor inicial
              Color.fromARGB(255, 255, 255, 255), // Uma cor final
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                    "Cadastro",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Informe o nome" : null,
                  ),
        
                  const SizedBox(height: 20),
        
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Informe o email" : null,
                  ),
        
                  const SizedBox(height: 20),
        
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Senha mínima 6 caracteres";
                      }
                      return null;
                    },
                  ),
        
                  const SizedBox(height: 30),
        
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: register,
                      child: const Text("Cadastrar"),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Já tem uma conta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        child: const Text("Fazer login"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
            ),
      )
    );
  }
}
