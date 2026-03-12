import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/splash_page.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://rowivngdnxeixisgzprm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvd2l2bmdkbnhlaXhpc2d6cHJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMDI2MTQsImV4cCI6MjA4ODY3ODYxNH0.d4Npa5D9GzXPWcUzFA4yd2DWJVvjMCyFWuWiOcn9rao'
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Potencialize',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),

        primaryColor: const Color(0xFF7C3AED),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7C3AED),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        colorScheme: const ColorScheme.light(
          primary: Color(0xFF7C3AED),
          secondary: Color(0xFFF59E0B),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFF7C3AED),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}