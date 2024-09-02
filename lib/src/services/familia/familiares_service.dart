import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xr1/src/env/env.dart';
import 'package:xr1/src/models/mi_familia.dart';
import 'package:get_storage/get_storage.dart';

class FamiliaService {
  final GetStorage _storage = GetStorage();

  Future<List<Datum>> obtenerFamilia() async {
    try {
      final token = await _storage.read('access_token');
      final userId = await _storage.read('cliente_id');
      if (kDebugMode) {
        print(token);
      }
      if (kDebugMode) {
        print(userId);
      }

      final url = Uri.parse(
          '${Env.apiUrl}v1/clientes/familiares'); // Cambia la URL según tu API

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        return data.map((datumJson) => Datum.fromJson(datumJson)).toList();
      } else {
        throw Exception('Ocurrio un error');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Datum> obtenerFamiliar(String familiarId) async {
    try {
      // Leer el token de autenticación y el ID del usuario desde el almacenamiento
      final token = await _storage.read('access_token');

      // Validar que el token esté disponible
      if (token == null) {
        throw Exception('Token is missing');
      }

      final url = Uri.parse(
          '${Env.apiUrl}v1/clientes/familiar'); // Cambia la URL según tu API

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': familiarId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final dynamic data = responseData['data'];

        // Convertir el JSON a un objeto Datum
        return Datum.fromJson(data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
