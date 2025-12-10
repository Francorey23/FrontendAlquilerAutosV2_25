import 'dart:convert';
import 'package:http/http.dart' as http;

class AutosService {
  final String baseUrl = 'https://bakendalquilerautos.onrender.com/api/autos';

  //registrar vehiculos  falta hacer el diseño de la vista
  Future<http.Response> registrarAuto(
      String marca,
      String modelo,
      String imagen,
      double valorAlquiler,
      String anio,
      int disponibilidad) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'marca': marca,
        'modelo': modelo,
        'imagenUrl': imagen,
        'valorAlquiler': valorAlquiler,
        'anio': anio,
        'disponibilidad': disponibilidad,
      }),
    );
    return response;
  }

  // Listar los vehiculos en menuOption

  /// Obtiene la lista de autos desde la API
  Future<List<Map<String, dynamic>>> obtenerAutosDisponibles() async {
    try {
      final url = Uri.parse(baseUrl);
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception(
            'Error al obtener los vehículos: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      // 🔹 Siempre terminamos con una List<dynamic> llamada "data"
      late final List<dynamic> data;

      if (decoded is List) {
        // Caso: API devuelve directamente una lista [ {}, {} ]
        data = decoded;
      } else if (decoded is Map<String, dynamic>) {
        // Caso: API envuelve la lista en alguna clave, ajusta si tu backend usa otro nombre
        if (decoded['data'] is List) {
          data = decoded['data'] as List<dynamic>;
        } else if (decoded['autos'] is List) {
          data = decoded['autos'] as List<dynamic>;
        } else {
          // Caso extremo: un solo auto como objeto
          data = [decoded];
        }
      } else {
        throw Exception(
            'Formato de respuesta inesperado: ${decoded.runtimeType}');
      }

      // 🔁 Mapear cada auto al formato que usará la UI
      return data.map<Map<String, dynamic>>((auto) {
        final num precioNum = (auto['valorAlquiler'] ?? 0) as num;

        return {
          'marca': auto['marca'],
          'modelo': auto['modelo'],
          'imageUrl': auto['imagen'] ?? 'https://picsum.photos/330/200',
          'precio': precioNum.toDouble(), // 👈 nombre 'precio'
          'anio': auto['anio'], // puede venir String o int
          'disponibilidad': auto['disponibilidad'], // puede ser 0/1 o bool
        };
      }).toList();
    } catch (e) {
      print('Error al obtener vehiculos : $e');
      return [];
    }
  }
}
