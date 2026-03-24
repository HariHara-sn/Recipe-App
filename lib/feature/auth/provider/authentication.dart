import 'package:hive_flutter/hive_flutter.dart';
import 'package:bloc/bloc.dart';

class AuthService extends Cubit<String?> {
  static const String _authBoxName = 'authBox';
  static const String _authTokenKey = 'authToken';
  static String get authBoxName => _authBoxName;
  final Box<dynamic> box = Hive.box(_authBoxName);

  AuthService() : super(null) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    emit(box.get(_authTokenKey));
  }

  Future<void> saveToken(String token) async {
    await box.put(_authTokenKey, token);
    emit(token); //state = token;
  }

  Future<void> clearToken() async {
    await box.delete(_authTokenKey);
    emit(null);
  }
}
