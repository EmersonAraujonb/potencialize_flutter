import 'package:flutter/material.dart';
import 'home_page.dart';
import '../services/auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const String _appVersion = "1.0.0+1";

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void login() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final response = await authService.signIn(email, password);

      if (response.session != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email ou senha inválidos"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email ou senha inválidos"),
        ),
      );
    }

    setState(() => _isLoading = false);
  }
}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        // Adiciona a decoração com o gradiente
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // Define o início e o fim do gradiente
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Lista de cores para o gradiente (mínimo de duas)
            colors: [
              Color.fromARGB(255, 152, 4, 250), // Uma cor inicial
              Color.fromARGB(255, 255, 255, 255), // Uma cor final
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // EMAIL
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe o email";
                      }
                      if (!value.contains("@")) {
                        return "Email inválido";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // SENHA
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
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : login,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Entrar"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não tem uma conta?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        child: const Text("Criar conta"),
                      ),
                    ],
                  ),
                ],
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}
