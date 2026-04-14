import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {

  final supabase = Supabase.instance.client;

  // 🔹 pegar perfil do usuário
  Future<Map<String, dynamic>> getProfile() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      throw Exception('Usuário não logado');
    }

    final profile = await supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();
        
        print(profile);

    return profile;
    
  }

  // 🔹 atualizar perfil
  Future<void> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {

    final user = supabase.auth.currentUser;

    if (user == null) return;

    await supabase.from('profiles').update({
      'name': name,
      'avatar_url': avatarUrl,
    }).eq('id', user.id);
  }
}