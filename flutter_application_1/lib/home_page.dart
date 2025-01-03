import 'package:flutter/material.dart';
import 'desafios_page.dart';
import 'recompensas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  const UserInfoRow(), // Usamos el widget UserInfoRow
                  const SizedBox(height: 16.0),
                  const SearchBox(), // Usamos el widget SearchBox
                  const SizedBox(height: 16.0), // Espacio adicional para separar
                  const PromoImagesRow(), // Usamos el widget PromoImagesRow
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Servicios Clipp',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Texto en negrita
                        fontSize: 16.0,
                        color: Colors.white, // Ajusta el color del texto
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const ColorfulServiceCards(), // Usamos el widget ColorfulServiceCards
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0), // Añadimos un padding superior
                    child: Text(
                      'Wallets y Tarjetas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Texto en negrita
                        fontSize: 16.0,
                        color: Colors.white, // Ajusta el color del texto
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const WalletsAndCards(), // Usamos el widget WalletsAndCards
                ],
              ),
            ),
            if (_isMenuVisible)
              Positioned(
                top: 50, // Ajusta la posición vertical
                right: 10, // Ajusta la posición horizontal
                child: GestureDetector(
                  onTap: () {}, // Evita que el menú se cierre al hacer clic dentro de él
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
      width: 205,
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A), // Mismo color que el cuadro de Saldo total
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recompensas Clipp',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () => navigateToPage(DesafiosPage()),
            child: MenuCard(
              icon: Icons.star,
              title: 'Desafíos',
              color: Colors.white, // Color blanco para el cuadro
            ),
          ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () => navigateToPage(RecompensasPage()),
            child: MenuCard(
              icon: Icons.redeem,
              title: 'Recompensas',
              color: Colors.white, // Color blanco para el cuadro
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
        color: color, // Color blanco para el cuadro
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(title, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 15.0),
            Image.asset(
              'assets/images/user.png',
              width: 60.0,
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Text(
                'Ubicación actual',
                style: TextStyle(color: Colors.white54, fontSize: 11.0),
              ),
            ),
            Text(
              'Bolivia y España, teb...',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
        SizedBox(width: 16.0),
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
            SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Image.asset(
                'assets/images/bell.png',
                width: 24.0,
                height: 24.0,
              ),
            ),
            SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: IconButton(
                icon: Image.asset('assets/images/trophy.png'),
                onPressed: () {
                  final parentState = context.findAncestorStateOfType<_HomePageState>();
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
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Color(0xFF747475),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextField(
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

class WalletsAndCards extends StatelessWidget {
  const WalletsAndCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Alineación uniforme
      children: [
        WalletCard(),
        QRCard(),
      ],
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

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
                '45.50 USD',
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
