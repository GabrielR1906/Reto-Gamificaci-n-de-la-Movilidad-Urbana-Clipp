import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _backendData = {
    'location': 'Bolivia y España...',
    'saldo': 45.50,
    'recompensas': [],
    'desafios': [
      {
        'titulo': 'Completa 5 viajes en Clipp',
        'progreso': 90,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un cupón de descuento del 25% en tu próximo viaje en taxi.',
        'recompensa': {
          'titulo': 'Entrada a concierto',
          'descripcion': 'Has ganado una entrada para el concierto de Clipp!',
          'icono': Icons.music_note,
          'qrCode': 'assets/images/qrclipp.png', 
        },
      },
      {
        'titulo': 'Utiliza 25USD en taxi en un mes',
        'progreso': 75,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un viaje en taxi gratuito.',
      },
      {
        'titulo': 'Haz 2 viajes en un día',
        'progreso': 50,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un descuento del 10% en tu siguiente viaje en esta semana.',
      },
      {
        'titulo': 'Viaja 3 veces en una semana',
        'progreso': 60,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un bono de 5 USD para tu siguiente viaje.',
      },
      {
        'titulo': 'Usa la app 10 veces en un mes',
        'progreso': 20,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un 20% de descuento en cualquier servicio Clipp.',
      },
      {
        'titulo': 'Gasta 50 USD en un mes',
        'progreso': 40,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-31',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un viaje en taxi gratuito en cualquier día festivo.',
      },
      {
        'titulo': 'Refiere a un amigo',
        'progreso': 10,
        'fechaInicio': '2025-01-01',
        'fechaFin': '2025-01-25',
        'icono': Icons.access_time,
        'descripcion': 'Recibiste un cupón de 10 USD para tu siguiente viaje.',
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
      var desafio = _backendData['desafios'][index];
      if (desafio.containsKey('recompensa')) {
        _backendData['recompensas'].add(desafio['recompensa']);
      } else {
        _backendData['recompensas'].add({
          'titulo': desafio['titulo'],
          'descripcion': desafio['descripcion'],
          'icono': Icons.check_circle,
        });
      }
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
