import 'package:flutter/material.dart';

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
      duration: Duration(seconds: 1),
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

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showCongratulations = false;
      });
    });
  }

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/desafios_icon.png', // Ajusta la ruta a tu imagen
                          width: 100,
                          height: 100,
                        ),
                        Text(
                          'Desafíos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Al completar los desafios podras recibir recompensas dentro de los servicios de clipp',
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
                        ChallengeDetail(
                          title: 'Completa 5 viajes en clipp',
                          progress: 55,
                          timeLeft: '2D 4H',
                        ),
                        SizedBox(height: 16.0),
                        ChallengeDetail(
                          title: 'Utiliza 25USD en taxi en un mes',
                          progress: 75,
                          timeLeft: '12D 10H',
                        ),
                        SizedBox(height: 16.0),
                        ChallengeDetail(
                          title: 'Haz 2 viajes en un día',
                          progress: 50,
                          timeLeft: '24H',
                          icon: Icons.access_time,
                        ),
                        SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: _showCongratulationsMessage,
                          child: ChallengeDetail(
                            title: 'Haz 3 pedidos a domicilio en una semana',
                            progress: 100,
                            timeLeft: 'Completado',
                            icon: Icons.check_circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  PromoImagesRow(),
                ],
              ),
              _showCongratulations
                  ? Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E3A5F), // Mismo tono azul que el cuadro de desafíos
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black, width: 1.0), // Contorno negro delgado
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Felicidades',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Haz conseguido un cupón de descuento en tu próximo viaje Clipp',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            ScaleTransition(
                              scale: _animationController,
                              child: Image.asset(
                                'assets/images/golden_ticket.png', // Ajusta la ruta a tu imagen
                                width: 500,
                                height: 500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
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
            style: TextStyle(color: Colors.white, fontSize: 16.0),
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              Column(
                children: [
                  Icon(icon ?? Icons.access_time, color: Colors.white),
                  Text(
                    timeLeft,
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
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
