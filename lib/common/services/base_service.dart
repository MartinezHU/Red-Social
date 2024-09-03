import 'dart:convert';

import 'package:social_app/common/interfaces/json_serializable.dart';

import 'common_service.dart';
import 'package:http/http.dart' as http;

class BaseService<T extends JsonSerializable> {
  final String baseUrl;
  final T Function(Map<String, dynamic>) fromJson;

  BaseService({required this.baseUrl, required this.fromJson});

  Future<List<T>> getAll() async {
    final response = await http.get(Uri.parse('$baseUrl/'), headers: headers());

    if (response.statusCode == 200) {
      final data = await customAutoDecode(response);

      List<dynamic> jsonList = jsonDecode(data);

      List<T> result = jsonList.map((json) => fromJson(json)).toList();

      return result;
    } else {
      throw Exception('Fail to retrieve the data');
    }
  }

  Future<T> getById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$id'),
        headers: headers(),
      );

      // Verifica el código de estado para determinar si la respuesta es exitosa
      if (response.statusCode == 200) {
        // Decodifica el cuerpo de la respuesta
        final data = await customAutoDecode(response);
        dynamic json = jsonDecode(data);

        // Usa la función fromJson para convertir el JSON en el objeto de tipo T
        T result = fromJson(json);
        return result;
      } else {
        // Lanza una excepción con un mensaje específico si falla
        throw Exception(
            'Failed to retrieve data for id $id with status code: ${response.statusCode}');
      }
    } catch (error) {
      // Captura cualquier otro error (como problemas de red) y lo propaga
      throw Exception('Error retrieving $T by ID $id: $error');
    }
  }

  Future<T> update(T entityToUpdate) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$entityToUpdate.id'),
        headers: headers(),
        body: jsonEncode(entityToUpdate.toJson()),
      );

      if (response.statusCode == 200) {
        dynamic jsonUpdate = jsonDecode(response.body);
        T updatedEntity = fromJson(jsonUpdate);
        return updatedEntity;
      } else {
        throw Exception(
            'Failed to updating $T by id $entityToUpdate.id with status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error updating $T by ID $entityToUpdate.id: $error');
    }
  }

  Future<bool> delete(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/$id'), headers: headers());

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Error deleting $T by ID $id');
      }
    } catch (error) {
      throw Exception('Error deleting $T by ID $id.id: $error');
    }
  }
}
