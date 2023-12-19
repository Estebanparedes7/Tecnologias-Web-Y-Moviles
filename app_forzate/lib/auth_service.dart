import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthResponse {
  final String? message;
  final int? statusCode;

  AuthResponse({required this.message, required this.statusCode});
}

class AuthService {
  final String baseUrl;
  static String? csrfToken;
  String? sessionToken;

  AuthService(this.baseUrl);

  // Obtener el token CSRF y guardarlo en la variable global csrfToken
  Future<void> getCsrfToken() async {
    try {
      if (csrfToken == null) {
        final response = await http.get(Uri.parse('$baseUrl/api/get_csrf_token/'));

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);
          csrfToken = data['csrf_token'];
          print("CSRF Token: $csrfToken");
        } else {
          throw Exception("Error al obtener el token CSRF");
        }
      }
    } catch (error) {
      throw Exception("Error al obtener el token CSRF: $error");
    }
  }

  // Iniciar sesión y guardar el token de sesión
  Future<AuthResponse> login(String email, String password) async {
    try {
      await getCsrfToken();

      final response = await http.post(
        Uri.parse('$baseUrl/api/login/'),
        body: {'username': email, 'password': password},
        headers: {
          'X-CSRFToken': csrfToken!,
          'Cookie': 'csrftoken=$csrfToken',
        },
      );

      print("HTTP Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String message = data['message'];

        // Guardar el token de sesión para usarlo en solicitudes subsiguientes
        sessionToken = response.headers['set-cookie'];

        return AuthResponse(message: message, statusCode: response.statusCode);
      } else {
        print("Error en inicio de sesión: ${response.body}");
        return AuthResponse(message: null, statusCode: response.statusCode);
      }
    } catch (error) {
      print("Error durante el inicio de sesión: $error");
      return AuthResponse(message: null, statusCode: null);
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String email) async {
  try {
    await getCsrfToken();

    final response = await http.get(
      Uri.parse('$baseUrl/api/get_user_info/?email=$email'), // Agrega el email a la URL
      headers: {
        'X-CSRFToken': csrfToken!,
        'Cookie': '$csrfToken; $sessionToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener la información del usuario");
    }
  } catch (error) {
    throw Exception("Error al obtener la información del usuario: $error");
  }
}

}
