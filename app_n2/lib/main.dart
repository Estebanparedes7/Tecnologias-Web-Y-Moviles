import 'package:flutter/material.dart';
import 'login.dart'; // Importar la clase Login desde el archivo login.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget principal que define la estructura básica de la aplicación
    return MaterialApp(
      title: 'Login', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal de la aplicación
      ),
      home: Login(), // Página de inicio de sesión como página principal
    );
  }
}
