import 'package:flutter/material.dart';

// Clase que representa la pantalla de inicio de sesión
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// Estado asociado a la pantalla de inicio de sesión
class _LoginState extends State<Login> {
  // Controladores para los campos de correo electrónico y contraseña
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  // Variable para recordar datos de inicio de sesión
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // Scaffold es el marco visual básico de la aplicación
    return Scaffold(
      // Contenedor que sirve como fondo con un degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
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
                // Título de la página
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                // Campo de entrada para el correo electrónico
                buildInputField(Icons.email, "Email", emailController),
                SizedBox(height: 20),
                // Campo de entrada para la contraseña
                buildInputField(
                  Icons.lock,
                  "Contraseña",
                  passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 8),
                // Enlace para olvidar la contraseña
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Lógica para manejar el olvido de la contraseña
                      print("¿Olvidaste tu contraseña?");
                    },
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Checkbox para recordar los datos
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
                SizedBox(height: 20),
                // Botón para iniciar sesión
                ElevatedButton(
                  onPressed: () {
                    // Validar los campos antes de proceder
                    String? errorMessage = validateInputs();
                    if (errorMessage == null) {
                      // Ambos campos están llenos y cumplen con las validaciones, proceder con la autenticación
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    } else {
                      // Mostrar un mensaje de error específico según la validación que falló
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: 20),
                // Iconos de redes sociales
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Lógica para redirigir a Facebook
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
                        // Lógica para redirigir a Google Traductor
                        print("Redirigiendo a Google Traductor");
                      },
                      icon: Icon(
                        Icons.g_translate_outlined,
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

// Esta función devuelve un widget de entrada de texto reutilizable
Widget buildInputField(
    IconData icon, String hint, TextEditingController controller,
    {bool isPassword = false}) {
  // El widget TextField es un campo de entrada de texto en Flutter
  return TextField(
    controller: controller, // El controlador que maneja el estado del campo de texto
    obscureText: isPassword, // Indica si el texto debe ser ocultado (contraseña)
    style: TextStyle(color: Colors.white), // Estilo del texto dentro del campo
    decoration: InputDecoration(
      // Configuración de decoración para el campo de entrada
      prefixIcon: Icon(icon, color: Colors.white), // Icono a la izquierda del campo
      hintText: hint, // Texto de sugerencia dentro del campo
      hintStyle: TextStyle(color: Colors.white), // Estilo del texto de sugerencia
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white), // Borde cuando no está enfocado
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white), // Borde cuando está enfocado
      ),
    ),
  );
}

  // Función para validar los campos de entrada
  String? validateInputs() {
    // Validar que el correo electrónico sea un correo electrónico válido
    bool isEmailValid = RegExp(
            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(emailController.text);

    // Validar que la contraseña tenga al menos 8 caracteres
    bool isPasswordValid = passwordController.text.length >= 8;

    // Mensaje de error según las validaciones que fallaron
    if (!isEmailValid) {
      return "Correo inválido";
    } else if (!isPasswordValid) {
      return "Contraseña muy corta (mínimo 8 caracteres)";
    }

    // Si todo está bien, devuelve null
    return null;
  }
}

// Página principal después de iniciar sesión
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Home",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
