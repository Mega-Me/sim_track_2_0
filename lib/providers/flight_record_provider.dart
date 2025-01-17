import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/flight_record_model.dart';

class FlightRecordProvider with ChangeNotifier {
  List<FlightRecord> _records = [];

  List<FlightRecord> get records => _records;

  // Fetch flight records from the backend API
  Future<void> fetchFlightRecords() async {
    final url = Uri.parse('http://localhost:5000/api/flight-records');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _records = data.map((record) => FlightRecord.fromJson(record)).toList();
        notifyListeners(); // Notify listeners to rebuild UI
      } else {
        throw Exception('Failed to load flight records');
      }
    } catch (error) {
      print('Error fetching flight records: $error');
      throw error;
    }
  }
}
