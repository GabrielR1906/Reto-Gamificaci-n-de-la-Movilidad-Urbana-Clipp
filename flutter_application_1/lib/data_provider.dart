import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  // Datos simulados
  Map<String, dynamic> _backendData = {
    'location': 'Bolivia y España',
    'saldo': 45.50,
    'recompensas': [
      {
        'titulo': 'Completa 5 viajes en Clipp',
        'descripcion': 'Recibiste un cupón de descuento del 25% en tu próximo viaje en taxi.',
        'icono': Icons.check_circle,
        'tiempoRestante': null,
      },
      {
        'titulo': 'Utiliza 25USD en taxi en un mes',
        'descripcion': 'Recibiste un viaje en taxi gratuito.',
        'icono': Icons.check_circle,
        'tiempoRestante': null,
      },
      {
        'titulo': 'Haz 2 viajes en un día',
        'descripcion': 'Recibiste un descuento del 10% en tu siguiente viaje en esta semana.',
        'icono': Icons.access_time,
        'tiempoRestante': '96H',
      },
    ],
    'desafios': [
      {
        'titulo': 'Completa 5 viajes en Clipp',
        'progreso': 55,
        'tiempoRestante': '2D 4H',
        'icono': Icons.access_time,
      },
      {
        'titulo': 'Utiliza 25USD en taxi en un mes',
        'progreso': 75,
        'tiempoRestante': '12D 10H',
        'icono': Icons.access_time,
      },
      {
        'titulo': 'Haz 2 viajes en un día',
        'progreso': 50,
        'tiempoRestante': '24H',
        'icono': Icons.access_time,
      },
    ],
  };

  // Método para obtener datos
  Map<String, dynamic> get backendData => _backendData;

  // Métodos para actualizar los datos
  void updateLocation(String newLocation) {
    _backendData['location'] = newLocation;
    notifyListeners();
  }

  void updateSaldo(double newSaldo) {
    _backendData['saldo'] = newSaldo;
    notifyListeners();
  }

  void updateRecompensa(int index, Map<String, dynamic> newRecompensa) {
    _backendData['recompensas'][index] = newRecompensa;
    notifyListeners();
  }

  void updateDesafio(int index, Map<String, dynamic> newDesafio) {
    _backendData['desafios'][index] = newDesafio;
    notifyListeners();
  }

}
