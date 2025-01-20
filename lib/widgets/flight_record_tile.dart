import 'package:flutter/material.dart';

class FlightRecordTile extends StatelessWidget {
  const FlightRecordTile({
    super.key,
    required this.flight_crew_logo,
    required this.flight_crew,
    required this.flight_date,
    required this.instructor_name_1,
    required this.instructor_id_1,
    required this.instructor_name_2,
    required this.instructor_id_2,
    required this.trainee_name_1,
    required this.trainee_id_1,
    required this.trainee_name_2,
    required this.trainee_id_2,
    required this.start_time,
    required this.end_time,
  });

  final String flight_crew_logo;
  final String flight_crew;
  final String flight_date;
  final String instructor_name_1;
  final String instructor_id_1;
  final String instructor_name_2;
  final String instructor_id_2;
  final String trainee_name_1;
  final String trainee_id_1;
  final String trainee_name_2;
  final String trainee_id_2;
  final String start_time;
  final String end_time;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column for crew details
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white10,
                  backgroundImage: AssetImage(flight_crew_logo),
                  radius: 40,
                ),
                Text(
                  flight_crew,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  flight_date,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Column for instructors and trainees
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Instructor: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      instructor_name_1,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      instructor_id_1,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Instructor: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      instructor_name_2,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      instructor_id_2,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Trainee: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      trainee_name_1,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      trainee_id_1,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Trainee: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      trainee_name_2,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      trainee_id_2,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Column for time details
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Start Time: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      start_time,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'End Time: ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      end_time,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Circular Progress Indicator
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.square(
                  dimension: 112,
                  child: CircularProgressIndicator(
                    value: 0.75, // 75% progress
                    color: Colors.green,
                    strokeWidth: 6.0,
                  ),
                ),
                const Text(
                  '75%',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
