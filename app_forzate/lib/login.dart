import 'package:flutter/material.dart';
import 'package:app_forzate/auth_service.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  AuthService authService = AuthService('https://hffckdm7-8000.brs.devtunnels.ms');

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(177, 240, 245, 1), const Color.fromARGB(255, 4, 111, 160)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 200, // Ajusta el ancho según tus necesidades
                height: 80, // Ajusta la altura según tus necesidades
              ),
              SizedBox(height: 10),
              buildInputField(Icons.email, "Email", emailController),
              SizedBox(height: 10),
              buildInputField(
                Icons.lock,
                "Contraseña",
                passwordController,
                isPassword: true,
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    print("¿Olvidaste tu contraseña?");
                  },
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                  Text(
                    'Recuerda tus datos',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await handleLogin();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: Text("Iniciar Sesión"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Redirigiendo a Facebook");
                    },
                    icon: Icon(
                      Icons.facebook,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      print("Redirigiendo a Google Traductor");
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget buildInputField(
      IconData icon, String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  String? validateInputs() {
    bool isEmailValid = RegExp(
            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(emailController.text);

    bool isPasswordValid = passwordController.text.length >= 6;

    if (!isEmailValid) {
      return "Correo inválido";
    } else if (!isPasswordValid) {
      return "Contraseña muy corta (mínimo 6 caracteres)";
    }

    return null;
  }

  Future<void> handleLogin() async {
    String? errorMessage = validateInputs();
    if (errorMessage == null) {
      String email = emailController.text;
      String password = passwordController.text;

      // Muestra un indicador de carga mientras se realiza la solicitud
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Iniciando sesión..."),
              ],
            ),
          );
        },
        barrierDismissible: false,
      );

      try {
        // Obtener el token CSRF antes de iniciar sesión
        await authService.getCsrfToken();

        AuthResponse response = await authService.login(email, password);
        Navigator.pop(context);

        if (response.message != null) {
          // Verificar el código de estado de la respuesta
          if (response.statusCode == 200) {
            // Credenciales correctas
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          } else {
            // Credenciales incorrectas
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.message!),
              ),
            );
          }
        } else {
          // Manejar otros casos de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Inicio de sesión fallido. Verifica tus credenciales."),
            ),
          );
        }
      } catch (error) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error durante el inicio de sesión. Inténtalo de nuevo."),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }
}