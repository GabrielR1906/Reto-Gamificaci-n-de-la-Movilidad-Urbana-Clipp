import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart'; // Importar DataProvider

class RecompensasPage extends StatelessWidget {
  const RecompensasPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    var recompensas = dataProvider.backendData['recompensas'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                      'assets/images/recompensas_icon.png',
                      width: 100,
                      height: 100,
                    ),
                    const Text(
                      'Recompensas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
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
              const SizedBox(height: 16.0),
              Container(
                width: double.infinity, // Abarcar todo el ancho
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: recompensas.isEmpty
                    ? const Center(
                        child: Text(
                          'Aún no obtienes ninguna recompensa. Completa un desafío para recibir una gran recompensa.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : Column(
                        children: recompensas.map<Widget>((recompensa) {
                          return Column(
                            children: [
                              RewardDetail(
                                title: recompensa['titulo'],
                                description: recompensa['descripcion'],
                                icon: recompensa['icono'],
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          );
                        }).toList(),
                      ),
              ),
              const SizedBox(height: 16.0),
              const PromoImagesRow(),
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

  const RewardDetail({
    required this.title,
    required this.description,
    required this.icon,
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
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(color: Colors.white54, fontSize: 14.0),
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
