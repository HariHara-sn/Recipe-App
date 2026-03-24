import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recepieapp/feature/auth/domain/models/auth_model.dart';

class UserService extends Cubit<LoginResponse?> {
  static const String _authBoxName = 'authBox';
  static const String _userDataKey = 'authUserData';
  static String get authBoxName => _authBoxName;

  final Box<dynamic> box = Hive.box(_authBoxName);

  UserService() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final rawData = box.get(_userDataKey);
      if (rawData != null) {
        final jsonMap = jsonDecode(rawData);
        emit(LoginResponse.fromJson(jsonMap));
      } else {
        emit(null);
      }
    } catch (e) {
      emit(null); // Fallback
    }
  }

  Future<void> saveUser(LoginResponse userData) async {
    await box.put(_userDataKey, jsonEncode(userData.toJson()));
    emit(userData);
  }

  Future<void> clearUser() async {
    await box.delete(_userDataKey);
    emit(null);
  }
}
