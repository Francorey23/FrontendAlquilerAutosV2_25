import 'dart:convert'; //permite codificar y decodificar archivos JSON
import 'package:http/http.dart' as http; //alias para referirme es http

class ClienteService {
  //Clase encapsula toda la logia para trabajar con API de cliente
  final String baseUrl =
      'https://bakendalquilerautos.onrender.com/api/clientes';

  //Metodo registrar cliente
  //Future indica que el metodo es asincrono y devuelve un objeto http.Response
  Future<http.Response> registrarCliente(
      String nombre, String correo, String numLic, String password) async {
    final url = Uri.parse('$baseUrl/'); // referencia la URL de render
    final response = await http.post(
      url, //metodo utilizado para enviar datos al servidor
      headers: {
        'Content-Type': 'application/json'
      }, //header tipo de dato enviado
      body: jsonEncode({
        'nombre': nombre,
        'correo': correo,
        'numLic': numLic,
        'password': password
      }), //convierte un objeto Dart (mapa de datos) en un JSON jsonEncode
    );
    return response;
  } //registro

  //Login
  Future<Map<String, dynamic>> loginCliente(
      String correo, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //header tipo de dato enviado
        body: jsonEncode({
          'correo': correo,
          'password': password,
        }));

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'success': true,
        'mensaje': responseData['mensaje'],
        'cliente': responseData['cliente']
      };
    } else {
      return {
        'success': false,
        'mensaje': responseData['mensaje'] ?? 'Credenciales incorrectas'
      };
    }
  }
}
