import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/flight_record_model.dart';

class FlightRecordProvider with ChangeNotifier {
  List<FlightRecord> _records = [];

  List<FlightRecord> get records => [..._records];

  Future<void> fetchFlightRecords() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/flight-records'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _records = data.map((item) => FlightRecord.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch flight records');
      }
    } catch (error) {
      print('Error fetching flight records: $error');
      throw error;
    }
  }

  Future<void> addFlightRecord(FlightRecord record) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/flight-records'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'flightCrew': record.flightCrew,
          'flightDate': record.flightDate,
          'instructor1': {
            'name': record.instructorName1,
            'reg': record.instructorId1,
          },
          'instructor2': {
            'name': record.instructorName2,
            'reg': record.instructorId2,
          },
          'trainee1': {
            'name': record.traineeName1,
            'reg': record.traineeId1,
          },
          'trainee2': {
            'name': record.traineeName2,
            'reg': record.traineeId2,
          },
          'startTime': record.startTime,
          'endTime': record.endTime,
          'flightCrewLogo': record.flightCrewLogo,
        }),
      );

      if (response.statusCode == 201) {
        // Add the new record to the list and notify listeners
        _records.add(FlightRecord.fromJson(json.decode(response.body)['record']));
        notifyListeners();
      } else {
        throw Exception('Failed to add flight record');
      }
    } catch (error) {
      print('Error adding flight record: $error');
      throw error;
    }
  }
}
