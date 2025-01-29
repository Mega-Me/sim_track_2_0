class MaintenanceRecord {
  final String id;
  final String aircraftName;
  final String maintenanceType;
  final String startDate;
  final String endDate;
  final String status; // e.g., "Pending", "Completed", etc.

  MaintenanceRecord({
    required this.id,
    required this.aircraftName,
    required this.maintenanceType,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) {
    return MaintenanceRecord(
      id: json['_id'], // Assuming MongoDB uses `_id`
      aircraftName: json['aircraftName'] ?? '',
      maintenanceType: json['maintenanceType'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
