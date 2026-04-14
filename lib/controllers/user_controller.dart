import 'package:flutter/material.dart';
import '../services/profile_service.dart';

class UserController extends ChangeNotifier {

  final profileService = ProfileService();

  String name = '';
  String? avatarUrl;
  bool isLoading = true;

  Future<void> loadUser() async {
    final profile = await profileService.getProfile();

    name = profile['name'] ?? '';
    avatarUrl = profile['avatar_url'];
    isLoading = false;

    notifyListeners();
  }

  void updateUser(String newName, String? newAvatar) {
    name = newName;
    avatarUrl = newAvatar;
    notifyListeners();
  }
}