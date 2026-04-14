import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';

class AuthService {

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future<AuthResponse> signUp(
  String name,
  String email,
  String password,
) async {
  return await supabase.auth.signUp(
    email: email,
    password: password,
    data: {
      'name': name,
    },
  );
}

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}