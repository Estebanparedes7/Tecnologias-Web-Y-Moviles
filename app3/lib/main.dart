import 'package:flutter/material.dart';
import 'widget.dart'; // Importa el archivo que contiene tu widget

void main() {
  runApp(MyApp());
}

// Clase principal de la aplicación que llama al widget principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PokemonCarouselScreen(), // Llama al widget que has creado
    );
  }
}
