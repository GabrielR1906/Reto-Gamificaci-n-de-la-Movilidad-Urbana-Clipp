import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';

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
      body: Padding(
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
              height: 300.0, // Establecer una altura fija para el contenedor
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
                  : ListView.builder(
                      itemCount: recompensas.length,
                      itemBuilder: (context, index) {
                        var recompensa = recompensas[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (recompensa['titulo'] == 'Entrada a concierto') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: const Color(0xFF87CEEB), // Azul claro
                                      title: Text(recompensa['titulo']),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Has ganado una entrada para el concierto de Clipp! Aquí está tu código QR que se puede usar como entrada al evento:'),
                                          const SizedBox(height: 16.0),
                                          Image.asset(
                                            'assets/images/qrclipp.png',
                                            width: 200.0,
                                            height: 200.0,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: RewardDetail(
                              title: recompensa['titulo'],
                              description: recompensa['descripcion'],
                              icon: recompensa['icono'],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16.0),
            const PromoImagesRow(), // Cuadros promocionales en la parte inferior
          ],
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
