import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _backendData = {
    'location': 'Bolivia y España',
    'saldo': 45.50,
    'recompensas': [
      // Lista de recompensas vacía al inicio
    ],
    'desafios': [
      {
        'titulo': 'Completa 5 viajes en Clipp',
        'progreso': 90, // Ejemplo de progreso
        'tiempoRestante': '2D 4H',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un cupón de descuento del 25% en tu próximo viaje en taxi.',
      },
      {
        'titulo': 'Utiliza 25USD en taxi en un mes',
        'progreso': 75,
        'tiempoRestante': '12D 10H',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un viaje en taxi gratuito.',
      },
      {
        'titulo': 'Haz 2 viajes en un día',
        'progreso': 50,
        'tiempoRestante': '24H',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un descuento del 10% en tu siguiente viaje en esta semana.',
      },
    ],
  };

  Map<String, dynamic> get backendData => _backendData;

  void updateLocation(String newLocation) {
    _backendData['location'] = newLocation;
    notifyListeners();
  }

  void updateSaldo(double newSaldo) {
    _backendData['saldo'] = newSaldo;
    notifyListeners();
  }

  void updateProgresoDesafio(int index, int progreso) {
    if (progreso >= 100) {
      _backendData['recompensas'].add({
        'titulo': _backendData['desafios'][index]['titulo'],
        'descripcion': _backendData['desafios'][index]['descripcion'],
        'icono': Icons.check_circle,
      });
      _backendData['desafios'].removeAt(index);
    } else {
      _backendData['desafios'][index]['progreso'] = progreso;
    }
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
