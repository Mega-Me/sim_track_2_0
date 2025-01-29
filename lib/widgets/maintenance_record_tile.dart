import 'package:flutter/material.dart';

class MaintenanceRecordTile extends StatelessWidget {
  final String aircraftName;
  final String maintenanceType;
  final String startDate;
  final String endDate;
  final String status;

  const MaintenanceRecordTile({
    super.key,
    required this.aircraftName,
    required this.maintenanceType,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            aircraftName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Type: $maintenanceType', style: const TextStyle(fontSize: 14)),
              Text('Status: $status', style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Text('Start Date: $startDate', style: const TextStyle(fontSize: 14)),
          Text('End Date: $endDate', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
