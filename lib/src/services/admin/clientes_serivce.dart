import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xr1/src/env/env.dart';
import 'package:xr1/src/models/clientes_model.dart';
import 'package:get_storage/get_storage.dart';

class AdminClientesService {
  final GetStorage _storage = GetStorage();

  Future<List<Cliente>> obtenerClientes() async {
    try {
      final token = await _storage.read('access_token');
      final userId = await _storage.read('admin_id');

      if (kDebugMode) {
        print(token);
        print(userId);
      }

      // Construir la URL con los parámetros de consulta
      final url = Uri.parse('${Env.apiUrl}v1/clientes');

      // Realizar la petición GET
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> data = responseData['data'];

        return data.map((datumJson) => Cliente.fromJson(datumJson)).toList();
      } else {
        throw Exception('Ocurrió un error');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Welcome> obtenerClienteConFamiliares(String id) async {
    try {
      // Leer el token de autenticación y el ID del usuario desde el almacenamiento
      final token = await _storage.read('access_token');

      // Validar que el token esté disponible
      if (token == null) {
        throw Exception('Token is missing');
      }

      final url = Uri.parse(
          '${Env.apiUrl}v1/clientes/familiares'); // Cambia la URL según tu API

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': id}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Convertir el JSON a un objeto Welcome
        return Welcome.fromJson(responseData);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
