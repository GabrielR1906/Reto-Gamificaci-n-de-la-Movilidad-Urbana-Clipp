import 'package:flutter/material.dart';

class UserInfoRow extends StatelessWidget {
  final Map<String, dynamic> backendData;

  const UserInfoRow({required this.backendData, super.key}); // Añadir const constructor y key

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
              backendData['location'] ?? 'Bolivia y España, teb...',
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
