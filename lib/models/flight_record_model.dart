import 'dart:convert';

class FlightRecord {
  final String id;
  final String flightCrewLogo;
  final String flightCrew;
  final String flightDate;

  FlightRecord({
    required this.id,
    required this.flightCrewLogo,
    required this.flightCrew,
    required this.flightDate,
  });

  // Factory method to create a FlightRecord from JSON
  factory FlightRecord.fromJson(Map<String, dynamic> json) {
    return FlightRecord(
      id: json['_id'],
      flightCrewLogo: json['flightCrewLogo'],
      flightCrew: json['flightCrew'],
      flightDate: json['flightDate'],
    );
  }
}
