import 'package:flutter_charset_detector/flutter_charset_detector.dart';
import 'package:http/http.dart';

Map<String, String> headers() {
  return {'Content-Type': 'application/json; charset=utf-8'};
}

// Función para detectar y convertir la response (El nombre de la función pueda cambiar).
Future<String> customAutoDecode(Response response) async {
  // Detecta la codificación y decodifica el contenido
  final result = await CharsetDetector.autoDecode(response.bodyBytes);

  // Devuelve el contenido decodificado como string
  return result.string;
}
