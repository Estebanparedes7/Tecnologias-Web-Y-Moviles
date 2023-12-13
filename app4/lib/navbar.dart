import 'package:flutter/material.dart';
import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0; // Índice de la pestaña actual

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi App con Tabs'),
      ),
      body: _buildBody(), // Contenido principal de la pantalla
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice de la pestaña actual en la barra de navegación
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambiar la pestaña actual cuando se toca en la barra de navegación
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _currentIndex, // Muestra solo el contenido de la pestaña actual
      children: [
        _buildCarousel(),    // Contenido de la primera pestaña (carrusel)
        _buildUserProfile(), // Contenido de la segunda pestaña (perfil)
      ],
    );
  }

  Widget _buildCarousel() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8, // Ancho del carrusel en relación con el ancho de la pantalla
        heightFactor: 0.5, // Altura del carrusel en relación con la altura de la pantalla
        child: CarouselSlider(
          items: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image1.jpg'),
                  fit: BoxFit.cover, // Ajusta la forma en que la imagen se ajusta al contenedor
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            height: 300.0,   // Altura total del carrusel
            autoPlay: true,  // Reproducción automática del carrusel
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8, // Ancho del perfil en relación con el ancho de la pantalla
        heightFactor: 0.5, // Altura del perfil en relación con la altura de la pantalla
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0, // Tamaño del avatar
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                print('Editar Perfil');
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
