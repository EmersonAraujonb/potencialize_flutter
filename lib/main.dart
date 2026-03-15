import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/splash_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // INICIALIZA SUPABASE
  await Supabase.initialize(
    url: 'https://rowivngdnxeixisgzprm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvd2l2bmdkbnhlaXhpc2d6cHJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMDI2MTQsImV4cCI6MjA4ODY3ODYxNH0.d4Npa5D9GzXPWcUzFA4yd2DWJVvjMCyFWuWiOcn9rao',
  );

  // CARREGA TEMA SALVO
  final prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('isDark') ?? false;

  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {

  final bool isDark;

  const MyApp({super.key, required this.isDark});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme(bool dark) async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', dark);

    setState(() {
      _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Potencialize',

      themeMode: _themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF7C3AED),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
          ),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
          ),
        ),
      ),

      home: const SplashPage(),
    );
  }
}
