import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../features/authentication/data/models/user_model.dart';
import '../../../features/authentication/domain/entities/user_entity.dart';

class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  UserEntity? _user;

  // ignore: unnecessary_getters_setters
  UserEntity? get user => _user;

  set user(UserEntity? user) {
    _user = user;
  }

  // Save user to secure storage
  Future<void> saveUser(UserEntity user) async {
    final UserModel userModel = UserModel.fromEntity(user);
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user', value: jsonEncode((userModel).toJson()));
    _user = user;
  }

  // Fetch user from secure storage
  Future<void> fetchUser() async {
    const storage = FlutterSecureStorage();
    final userJson = await storage.read(key: 'user');
    if (userJson != null) {
      _user = UserModel.fromJson(jsonDecode(userJson));
    }
  }

  // Clear user data from secure storage
  Future<void> clearUser() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'user');
    _user = null;
  }
}