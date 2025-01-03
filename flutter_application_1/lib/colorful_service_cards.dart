import 'package:flutter/material.dart';

class ColorfulServiceCards extends StatelessWidget {
  const ColorfulServiceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
          children: [
            ServiceCard(
              color: Colors.orange,
              imagePath: 'assets/images/taxi.png',
              size: 80.0,
            ),
            ServiceCard(
              color: Colors.blue,
              imagePath: 'assets/images/eventos.png',
              size: 80.0,
            ),
            ServiceCard(
              color: Colors.teal,
              imagePath: 'assets/images/delivery.png',
              size: 80.0,
            ),
          ],
        ),
        SizedBox(height: 10.0), // Espacio entre las filas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
          children: [
            ServiceCard(
              color: Colors.white,
              imagePath: 'assets/images/pagos.png',
              size: 80.0,
            ),
            ServiceCard(
              color: Colors.white,
              imagePath: 'assets/images/farm.png',
              size: 80.0,
            ),
            ServiceCard(
              color: Colors.white,
              imagePath: 'assets/images/situ.png',
              size: 80.0,
            ),
          ],
        ),
      ],
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Color color;
  final String imagePath;
  final double size;

  const ServiceCard({
    required this.color,
    required this.imagePath,
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Espacio entre los cuadros
      child: Container(
        width: 90.0, // Ajusta el ancho del cuadro
        height: 90.0, // Ajusta la altura del cuadro
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
