import 'package:flutter/material.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  double passwordStrength = 0;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  void checkPassword(String value) {
    double strength = 0;

    if (value.length >= 6) strength += 0.3;
    if (value.length >= 10) strength += 0.3;
    if (RegExp(r'[A-Z]').hasMatch(value)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(value)) strength += 0.2;

    setState(() {
      passwordStrength = strength.clamp(0, 1);
    });
  }

  void register() {
    if (_formKey.currentState!.validate()) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Conta criada com sucesso"),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Color getStrengthColor() {
    if (passwordStrength < 0.4) return Colors.red;
    if (passwordStrength < 0.7) return Colors.orange;
    return Colors.green;
  }

  String getStrengthText() {
    if (passwordStrength < 0.4) return "Senha fraca";
    if (passwordStrength < 0.7) return "Senha média";
    return "Senha forte";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

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

                elevation: 12,

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
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: const Color(0xFF7C3AED),
                              child: const Icon(
                                Icons.school,
                                size: 36,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              "Potencialize",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// NOME
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Nome",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? "Informe seu nome" : null,
                        ),

                        const SizedBox(height: 20),

                        /// EMAIL
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) =>
                              value!.contains("@") ? null : "Email inválido",
                        ),

                        const SizedBox(height: 20),

                        /// SENHA
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          onChanged: checkPassword,
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

                        const SizedBox(height: 10),

                        /// FORÇA DA SENHA
                        LinearProgressIndicator(
                          value: passwordStrength,
                          color: getStrengthColor(),
                          backgroundColor: Colors.grey[300],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          getStrengthText(),
                          style: TextStyle(
                            color: getStrengthColor(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// BOTÃO CADASTRAR
                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            onPressed: register,
                            child: const Text("Criar conta"),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// LOGIN
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Text("Já tem conta?"),

                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Entrar"),
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