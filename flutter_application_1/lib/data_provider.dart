import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  Map<String, dynamic> _backendData = {
    'location': 'Bolivia y España',
    'saldo': 45.50,
    // Agrega otros datos simulados aquí
  };

  Map<String, dynamic> get backendData => _backendData;

  void updateData(String key, dynamic value) {
    _backendData[key] = value;
    notifyListeners();
  }
}
