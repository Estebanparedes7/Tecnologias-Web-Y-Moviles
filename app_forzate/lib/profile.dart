// profile.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String nombre;
  final String apellido;

  ProfileScreen({required this.nombre, required this.apellido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color.fromARGB(255, 62, 122, 177),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nombre: $nombre',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Apellido: $apellido',
              style: TextStyle(fontSize: 20),
            ),
            // Puedes agregar más información del perfil según sea necesario
          ],
        ),
      ),
    );
  }
}
