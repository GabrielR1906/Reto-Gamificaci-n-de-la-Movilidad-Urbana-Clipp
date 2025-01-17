import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart'; // Importar DataProvider

class DesafiosPage extends StatefulWidget {
  const DesafiosPage({super.key});

  @override
  _DesafiosPageState createState() => _DesafiosPageState();
}

class _DesafiosPageState extends State<DesafiosPage>
    with SingleTickerProviderStateMixin {
  bool _showCongratulations = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showCongratulationsMessage() {
    setState(() {
      _showCongratulations = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showCongratulations = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    var desafios = dataProvider.backendData['desafios'];

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/desafios_icon.png',
                        width: 100,
                        height: 100,
                      ),
                      const Text(
                        'Desafíos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Al completar los desafíos podrás recibir recompensas dentro de los servicios de Clipp',
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
                // Contenedor azul para los desafíos
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A5F),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: desafios.length,
                    itemBuilder: (context, index) {
                      var desafio = desafios[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            int newProgreso = desafio['progreso'] + 10;
                            dataProvider.updateProgresoDesafio(index, newProgreso);
                            if (newProgreso >= 100) {
                              _showCongratulationsMessage();
                            }
                          },
                          child: ChallengeDetail(
                            title: desafio['titulo'],
                            progress: desafio['progreso'],
                            timeLeft: desafio['tiempoRestante'],
                            icon: desafio['icono'],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                const PromoImagesRow(), // Asegúrate de agregar esto para mostrar las promociones
              ],
            ),
          ),
          if (_showCongratulations)
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A5F),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Felicidades',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Haz conseguido una nueva recompensa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ScaleTransition(
                      scale: _animationController,
                      child: Image.asset(
                        'assets/images/golden_ticket.png',
                        width: 200, // Aumenta el tamaño de la imagen del ticket
                        height: 200, // Aumenta el tamaño de la imagen del ticket
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Botón oculto para incrementar el progreso del primer desafío al 100%
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: GestureDetector(
              onLongPress: () {
                dataProvider.updateProgresoDesafio(0, 100); // Completar el primer desafío al 100%
                _showCongratulationsMessage();
              },
              child: Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.transparent, // Hacer el botón transparente
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChallengeDetail extends StatelessWidget {
  final String title;
  final int progress;
  final String timeLeft;
  final IconData? icon;

  const ChallengeDetail({
    required this.title,
    required this.progress,
    required this.timeLeft,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: Stack(
                  children: [
                    Container(
                      height: 25.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress / 100,
                      child: Container(
                        height: 25.0,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$progress%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Column(
                children: [
                  Icon(icon ?? Icons.access_time, color: Colors.white),
                  Text(
                    timeLeft,
                    style: const TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ],
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
