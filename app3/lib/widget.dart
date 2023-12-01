import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Carousel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonCarouselScreen(),
    );
  }
}

class PokemonCarouselScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Carousel'),
      ),
      body: Center(
        child: PokemonCarousel(),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final String nombre;
  final String elemento;
  final int numeroPokedex;

  PokemonCard({required this.nombre, required this.elemento, required this.numeroPokedex});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset('assets/$nombre.png', height: 200, width: 200),
          Text(
            '$nombre',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18, // Puedes ajustar el tamaño según tus preferencias
            ),
          ),
          PokemonTag(elemento: elemento),
          Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(), // Espacio en blanco a la izquierda
              Text(
                'Pokédex #$numeroPokedex',
                style: TextStyle(
                  fontSize: 14, // Puedes ajustar el tamaño según tus preferencias
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class PokemonTag extends StatelessWidget {
  final String elemento;

  PokemonTag({required this.elemento});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (elemento.toLowerCase()) {
      case 'planta':
        color = Colors.green;
        break;
      case 'fuego':
        color = Colors.orange;
        break;
      case 'agua':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        elemento,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class PokemonCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0,
        enableInfiniteScroll: true,
      ),
      items: [
        PokemonCard(nombre: 'Bulbasaur', elemento: 'Planta', numeroPokedex: 1),
        PokemonCard(nombre: 'Charmander', elemento: 'Fuego', numeroPokedex: 4),
        PokemonCard(nombre: 'Squirtle', elemento: 'Agua', numeroPokedex: 7),
        // aqui se puede agregar mas pokemon
      ],
    );
  }
}
