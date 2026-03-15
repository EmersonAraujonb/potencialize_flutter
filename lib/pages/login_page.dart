import 'package:app_cursos/pages/main_page.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

  static const String _appVersion = "1.0.0+1";

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();

  bool _obscurePassword = true;
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

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
              builder: (_) => const MainPage(),
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
          const SnackBar(
            content: Text("Erro ao fazer login"),
            backgroundColor: Colors.red,
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          "Versão $_appVersion",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ),

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF7C3AED),
              Color(0xFFEDE9FE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(

          child: FadeTransition(

            opacity: _fadeAnimation,

            child: SingleChildScrollView(

              padding: const EdgeInsets.all(24),

              child: Card(

                elevation: 10,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(

                  padding: const EdgeInsets.all(28),

                  child: Form(

                    key: _formKey,

                    child: Column(

                      mainAxisSize: MainAxisSize.min,

                      children: [

                        /// LOGO
                        Column(
                          children: const [

                            CircleAvatar(
                              radius: 36,
                              backgroundColor: Color(0xFF7C3AED),
                              child: Icon(
                                Icons.school,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 12),

                            Text(
                              "Potencialize",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// EMAIL
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
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

                        /// SENHA
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            prefixIcon: const Icon(Icons.lock),
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

                        /// BOTÃO LOGIN
                        SizedBox(
                          width: double.infinity,
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

                            const Text("Não tem conta?"),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                );
                              },

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
          ),
        ),
      ),
    );
  }
}