import 'package:flutter/material.dart';

class SimulatorProvider with ChangeNotifier {
  String _selectedSimulator = "Default Simulator";

  String get selectedSimulator => _selectedSimulator;

  void setSimulator(String newSimulator) {
    _selectedSimulator = newSimulator;
    notifyListeners(); // Notify UI to update
  }
}