import 'package:flutter/material.dart';

class RecompensasPage extends StatelessWidget {
  const RecompensasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/recompensas_icon.png', // Ajusta la ruta a tu imagen
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Recompensas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Aquí están las recompensas que has ganado completando los desafíos en Clipp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF1E3A5F), // Tono azul más claro que el fondo
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    RewardDetail(
                      title: 'Completa 5 viajes en clipp',
                      description:
                          'Recibiste un cupón de descuento del 25 % en tu próximo viaje en taxi.',
                      icon: Icons.check_circle,
                    ),
                    SizedBox(height: 16.0),
                    RewardDetail(
                      title: 'Utiliza 25USD en taxi en un mes',
                      description: 'Recibiste un viaje en taxi gratuito.',
                      icon: Icons.check_circle,
                    ),
                    SizedBox(height: 16.0),
                    RewardDetail(
                      title: 'Haz 2 viajes en un día',
                      description:
                          'Recibiste un descuento del 10% en tu siguiente viaje en esta semana.',
                      icon: Icons.access_time,
                      timeLeft: '96H', // Tiempo límite para usar la recompensa
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              PromoImagesRow(),
            ],
          ),
        ),
      ),
    );
  }
}
class RewardDetail extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String? timeLeft; // Campo opcional para el tiempo restante

  const RewardDetail({
    required this.title,
    required this.description,
    required this.icon,
    this.timeLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.green),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(color: Colors.white54, fontSize: 14.0),
          ),
          if (timeLeft != null)
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.white),
                SizedBox(width: 4.0),
                Text(
                  timeLeft!,
                  style: TextStyle(color: Colors.white54, fontSize: 12.0),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
class PromoImagesRow extends StatelessWidget {
  const PromoImagesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 175.0,
                  height: 100.0,
                  child: Image.asset(
                    'assets/images/promo1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
