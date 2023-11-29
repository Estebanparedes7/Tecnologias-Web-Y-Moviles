import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sedes Universidad de Los Lagos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cards
            _buildCard(
              'assets/image1.png', // Ruta de la imagen 1 en la carpeta assets
              'Título 1',
              'Ulagos Sede Osorno',
            ),
            _buildCard(
              'assets/image2.png', // Ruta de la imagen 2 en la carpeta assets
              'Título 2',
              'Ulagos Sede Puerto Montt',
            ),
            _buildCard(
              'assets/image3.png', // Ruta de la imagen 3 en la carpeta assets
              'Título 3',
              'Ulagos Sede Chiloé',
            ),

            SizedBox(height: 5), // Espaciador vertical

            // Botón para redirigir a la página de Ulagos
            ElevatedButton(
              onPressed: () {
                _irAUlagos(context);
              },
              child: Text('Mas información'),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(), // Borde redondo
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//funcion para abrir url
void _irAUlagos(BuildContext context) async {
  const url = 'http://www.ulagos.cl'; // URL de la página de Ulagos
  try {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } catch (e) {
    throw 'No se puede abrir la URL: $url';
  }
}


}
