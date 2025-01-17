import 'package:flutter/material.dart';
class FlightRecordTile extends StatelessWidget {
  const FlightRecordTile({super.key,
    required this.flight_crew_logo,
    required this.flight_crew,
    required this.flight_date,
    // required this.instructor_name_1,
    // required this.instructor_id_1,
    // required this.instructor_name_2,
    // required this.instructor_id_2,
  });
  final String flight_crew_logo;
  final String flight_crew;
  final String flight_date;
  // final String instructor_name_1;
  // final String instructor_id_1;
  // final String instructor_name_2;
  // final String instructor_id_2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Instructor : ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "instructor_name_1",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "instructor_id_1",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Instructor : ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "instructor_name_2",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "instructor_name_2",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Trainee :',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Trainee Name ',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '  Trainee ID',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Trainee : ',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Trainee ID',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '  Trainee ID',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Start Time : ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Start Time',
                    style: const TextStyle(
                      fontSize: 16,

                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'End Time : ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'End Time',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.square(
                dimension: 112,
                child: CircularProgressIndicator(
                  value: 75,
                  color: Colors.green,
                  strokeWidth: 24.0,
                ),
              ),
              Text(
                '${100}%',
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
