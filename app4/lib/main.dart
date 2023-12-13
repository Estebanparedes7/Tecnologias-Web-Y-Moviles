import 'package:flutter/material.dart';
import 'navbar.dart'; // Importa la clase Navbar desde el archivo navbar.dart

void main() {
  runApp(MyApp()); // Inicia la aplicación Flutter
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navbar(), // Establece la clase Navbar como la pantalla de inicio
    );
  }
}
