import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'desafios_page.dart'; // Importar correctamente
import 'recompensas_page.dart'; // Importar correctamente
import 'data_provider.dart'; // Importar DataProvider

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isMenuVisible = false;

  void _toggleMenu() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  void _hideMenu() {
    setState(() {
      _isMenuVisible = false;
    });
  }

  void _navigateToPage(Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_isMenuVisible) {
            _hideMenu();
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinear elementos en la parte superior
                children: [
                  UserInfoRow(dataProvider: dataProvider), // Pasar DataProvider al widget
                  const SizedBox(height: 16.0),
                  const SearchBox(),
                  const SizedBox(height: 16.0),
                  const PromoImagesRow(),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Servicios Clipp',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const ColorfulServiceCards(),
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Wallets y Tarjetas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const WalletsAndCards(),
                ],
              ),
            ),
            if (_isMenuVisible)
              Positioned(
                top: 50,
                right: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: FloatingMenu(navigateToPage: _navigateToPage),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class FloatingMenu extends StatelessWidget {
  final Function(Widget) navigateToPage;

  const FloatingMenu({required this.navigateToPage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF06233E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recompensas Clipp',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: () => navigateToPage(const DesafiosPage()),
            child: const MenuCard(
              icon: Icons.star,
              title: 'Desafíos',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          GestureDetector(
            onTap: () => navigateToPage(const RecompensasPage()),
            child: const MenuCard(
              icon: Icons.redeem,
              title: 'Recompensas',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const MenuCard({
    required this.icon,
    required this.title,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final DataProvider dataProvider;

  const UserInfoRow({required this.dataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 15.0),
            Image.asset(
              'assets/images/user.png',
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Text(
                'Ubicación actual',
                style: TextStyle(color: Colors.white54, fontSize: 11.0),
              ),
            ),
            Text(
              dataProvider.backendData['location'] ?? 'Ubicación desconocida',
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/arrow.png',
                width: 24.0,
                height: 24.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/bell.png',
                width: 24.0,
                height: 24.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: IconButton(
                icon: Image.asset('assets/images/trophy.png'),
                onPressed: () {
                  final parentState = context.findAncestorStateOfType<HomePageState>();
                  if (parentState != null) {
                    parentState._toggleMenu();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF747475),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'A dónde vas?',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
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











class ColorfulServiceCards extends StatelessWidget {
  const ColorfulServiceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
          children: [
            Expanded(
              child: ServiceCard(
                color: const Color(0xFFF9930D), // Color #f9930d
                imagePath: 'assets/images/taxi.png',
                size: 80.0,
                title: 'Taxi', // Texto "Taxi"
                textColor: Colors.white, // Color del texto blanco
                textSize: 14.0, // Tamaño del texto para cuadros más grandes
                height: 130.0, // Altura de cuadros grandes
              ),
            ),
            Expanded(
              child: ServiceCard(
                color: const Color(0xFF65E8FB), // Color #65E8FB
                imagePath: 'assets/images/eventos.png',
                size: 80.0,
                title: 'Eventos', // Texto "Eventos"
                textColor: Colors.white, // Color del texto blanco
                textSize: 14.0, // Tamaño del texto para cuadros más grandes
                height: 130.0, // Altura de cuadros grandes
              ),
            ),
            Expanded(
              child: ServiceCard(
                color: const Color(0xFFAFE4D2), // Color #AFE4D2
                imagePath: 'assets/images/delivery.png',
                size: 80.0,
                title: 'Delivery', // Texto "Delivery"
                textColor: Colors.white, // Color del texto blanco
                textSize: 14.0, // Tamaño del texto para cuadros más grandes
                height: 130.0, // Altura de cuadros grandes
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0), // Espacio entre las filas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
          children: [
            Expanded(
              child: ServiceCard(
                color: Colors.white,
                imagePath: 'assets/images/pagos.png',
                size: 60.0,
                title: 'Pagos y Recargas', // Texto "Pagos y Recargas"
                textColor: Colors.black, // Color del texto negro
                textSize: 10.0, // Tamaño del texto para cuadros más pequeños
                height: 110.0, // Altura de cuadros pequeños
              ),
            ),
            Expanded(
              child: ServiceCard(
                color: Colors.white,
                imagePath: 'assets/images/farm.png',
                size: 60.0,
                title: 'Farm. Cuxibamba', // Texto "Farm. Cuxibamba"
                textColor: Colors.black, // Color del texto negro
                textSize: 10.0, // Tamaño del texto para cuadros más pequeños
                height: 110.0, // Altura de cuadros pequeños
              ),
            ),
            Expanded(
              child: ServiceCard(
                color: Colors.white,
                imagePath: 'assets/images/situ.png',
                size: 60.0,
                title: 'Situ SIU', // Texto "Situ SIU"
                textColor: Colors.black, // Color del texto negro
                textSize: 10.0, // Tamaño del texto para cuadros más pequeños
                height: 110.0, // Altura de cuadros pequeños
              ),
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
  final String title; // Título para cada cuadro
  final Color textColor; // Color del texto
  final double textSize; // Tamaño del texto
  final double height; // Altura del cuadro

  const ServiceCard({
    required this.color,
    required this.imagePath,
    required this.size,
    required this.title, // Parámetro para el título
    required this.textColor, // Parámetro para el color del texto
    this.textSize = 12.0, // Parámetro para el tamaño del texto con valor por defecto
    this.height = 110.0, // Parámetro para la altura del cuadro con valor por defecto
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0), // Espacio entre los cuadros
      child: Container(
        height: height, // Ajusta la altura del cuadro
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espacio entre el contenido y el texto
          children: [
            Image.asset(
              imagePath,
              width: size,
              height: size,
            ),
            Text(
              title,
              style: TextStyle(color: textColor, fontSize: textSize), // Ajusta el tamaño del texto
            ),
          ],
        ),
      ),
    );
  }
}


















class WalletsAndCards extends StatelessWidget {
  const WalletsAndCards({super.key});

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    var saldo = dataProvider.backendData['saldo'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        WalletCard(saldo: saldo),
        const QRCard(),
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
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF06233E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Saldo total',
                style: TextStyle(fontSize: 12.0, color: Colors.white54),
              ),
              const SizedBox(height: 5.0),
              Text(
                '${saldo.toStringAsFixed(2)} USD',
                style: const TextStyle(
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
                'assets/images/circle.png',
                width: 28.0,
                height: 28.0,
              ),
              Image.asset(
                'assets/images/arrow_2.png',
                width: 20.0,
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
      width: 80.0,
      height: 80.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF06233E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/qr_code.png',
          width: 50.0,
          height: 50.0,
        ),
      ),
    );
  }
}
