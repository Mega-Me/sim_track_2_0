import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sim_track_2_0/models/maintenance_record_model.dart';
import 'dart:convert';

import 'package:sim_track_2_0/screens/sim_schedule_screen.dart';

class MaintenanceRecordProvider with ChangeNotifier {
  List<MaintenanceRecord> _records = [];

  List<MaintenanceRecord> get records => [..._records];

  Future<void> fetchMaintenanceRecords() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/maintenance-records'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _records = data.map((item) => MaintenanceRecord.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch maintenance records');
      }
    } catch (error) {
      print('Error fetching maintenance records: $error');
      throw error;
    }
  }

  Future<void> addMaintenanceRecord(MaintenanceRecord record) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/maintenance-records'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'aircraftName': record.aircraftName,
          'maintenanceType': record.maintenanceType,
          'startDate': record.startDate,
          'endDate': record.endDate,
          'status': record.status,
        }),
      );

      if (response.statusCode == 201) {
        _records.add(MaintenanceRecord.fromJson(json.decode(response.body)['record']));
        notifyListeners();
      } else {
        throw Exception('Failed to add maintenance record');
      }
    } catch (error) {
      print('Error adding maintenance record: $error');
      throw error;
    }
  }
}
