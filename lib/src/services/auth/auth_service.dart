import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:xr1/src/env/env.dart';

class AuthService extends GetxService {
  final GetStorage _storage = GetStorage();

  Future<bool> login(String email, String password) async {
    const url =
        '${Env.apiUrl}v1/auth/cliente/login'; // Usa la variable apiUrl del archivo env.dart
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (kDebugMode) {
      print('Response body: ${response.body}');
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['access_token'];
      Map<String, dynamic> cliente = data['cliente'];
      await _storage.write('cliente_id', cliente['id']);
      // Guardar el token en GetStorage
      _storage.write('access_token', token);
      await _storage.write('cliente', cliente);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginAdmin(String email, String password) async {
    const url = '${Env.apiUrl}v1/auth/admin/login';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (kDebugMode) {
      print('Response body: ${response.body}');
    }
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['access_token'];

      // Accede al primer elemento de la lista 'user'
      Map<String, dynamic> user = data['user'][0];

      await _storage.write('admin_id', user['id']);
      await _storage.write('role', user['role']);
      // Guardar el token en GetStorage
      _storage.write('access_token', token);
      await _storage.write('user', user);

      return true;
    } else {
      return false;
    }
  }

  // Método para obtener el token
  String? getToken() {
    return _storage.read('access_token');
  }

  // Método para eliminar el token (logout)
  Future<void> logout() async {
    await _storage.remove('access_token');
    await _storage.remove('cliente');
    await _storage.remove('cliente_id');
    await _storage.remove('admin_id');
    await _storage.remove('role');
    await _storage.remove('user');
  }
}
