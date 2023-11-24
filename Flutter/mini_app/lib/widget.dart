import 'package:flutter/material.dart';

// Definición del widget principal de la aplicación
class MiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi App Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Texto explicativo
            Text(
              'Presiona para saludar:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            // Botón para activar la función de saludo
            ElevatedButton(
              onPressed: () {
                _mostrarHolaMundo(context);
              },
              child: Text('¡Hola Mundo!'),
            ),
          ],
        ),
      ),
    );
  }
  // Función para mostrar un cuadro de diálogo con el saludo
  void _mostrarHolaMundo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Hola Mundo!'),
          content: Text('¡Hola Mundo!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
