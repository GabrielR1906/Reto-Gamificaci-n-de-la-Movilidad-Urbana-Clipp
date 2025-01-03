import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart'; // Importa el DataProvider

class WalletsAndCards extends StatelessWidget {
  const WalletsAndCards({super.key});

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
      children: [
        WalletCard(saldo: dataProvider.backendData['saldo']),
        QRCard(),
      ],
    );
  }
}

class WalletCard extends StatelessWidget {
  final double saldo;

  const WalletCard({required this.saldo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 80.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A), // Color más claro que el fondo
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo total',
                style: TextStyle(fontSize: 12.0, color: Colors.white54),
              ),
              SizedBox(height: 5.0),
              Text(
                '${saldo.toStringAsFixed(2)} USD',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/circle.png', // Imagen del círculo
                width: 28.0, // Ajusta el tamaño del círculo
                height: 28.0,
              ),
              Image.asset(
                'assets/images/arrow_2.png', // Imagen de la flecha
                width: 20.0, // Ajusta el tamaño de la flecha
                height: 20.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QRCard extends StatelessWidget {
  const QRCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0, // Ajusta el tamaño del cuadro QR
      height: 80.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A), // Color más claro que el fondo
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/qr_code.png', // Ajusta la ruta a tu imagen de código QR
          width: 50.0,
          height: 50.0,
        ),
      ),
    );
  }
}
