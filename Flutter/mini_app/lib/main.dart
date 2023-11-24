import 'package:flutter/material.dart';
import 'widget.dart'; // Importa el archivo que contiene el widget

void main() {
  runApp(MyApp());
}
// Clase principal de la aplicación que llama al widget principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MiWidget(), // Llama al widget creado
    );
  }
}
