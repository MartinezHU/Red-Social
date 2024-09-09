import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

import '../../features/auth/utils/tokens_storage.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();
final TokenStorage tokenStorage = TokenStorage(storage);

Map<String, String> basicHeaders() {
  return {'Content-Type': 'application/json; charset=utf-8'};
}

Future<Map<String, String>> authHeaders() async {
  try {
    final String? accessToken = await tokenStorage.getAccessToken();

    // Construir los encabezados
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  } catch (e) {
    // Manejo de errores, por ejemplo, puedes registrar el error o devolver un encabezado vacío
    print('Error obteniendo los encabezados de autenticación: $e');
    return {
      'Content-Type': 'application/json; charset=utf-8',
    };
  }
}

// Función para detectar y convertir la response (El nombre de la función pueda cambiar).
Future<String> customAutoDecode(Response response) async {
  // Detecta la codificación y decodifica el contenido
  final result = await CharsetDetector.autoDecode(response.bodyBytes);

  // Devuelve el contenido decodificado como string
  return result.string;
}
