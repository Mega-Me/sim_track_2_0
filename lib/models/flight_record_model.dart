class FlightRecord {
  final String flightCrew;
  final String flightDate;
  final String instructorName1;
  final String instructorId1;
  final String instructorName2;
  final String instructorId2;
  final String traineeName1;
  final String traineeId1;
  final String traineeName2;
  final String traineeId2;
  final String startTime;
  final String endTime;
  final String flightCrewLogo;

  FlightRecord({
    required this.flightCrew,
    required this.flightDate,
    required this.instructorName1,
    required this.instructorId1,
    required this.instructorName2,
    required this.instructorId2,
    required this.traineeName1,
    required this.traineeId1,
    required this.traineeName2,
    required this.traineeId2,
    required this.startTime,
    required this.endTime,
    this.flightCrewLogo = '',
  });

  factory FlightRecord.fromJson(Map<String, dynamic> json) {
    return FlightRecord(
      flightCrew: json['flightCrew'] ?? '',
      flightDate: json['flightDate'] ?? '',
      instructorName1: json['instructor1']['name'] ?? '',
      instructorId1: json['instructor1']['reg'] ?? '',
      instructorName2: json['instructor2']['name'] ?? '',
      instructorId2: json['instructor2']['reg'] ?? '',
      traineeName1: json['trainee1']['name'] ?? '',
      traineeId1: json['trainee1']['reg'] ?? '',
      traineeName2: json['trainee2']['name'] ?? '',
      traineeId2: json['trainee2']['reg'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      flightCrewLogo: json['flightCrewLogo'] ?? '',
    );
  }
}
