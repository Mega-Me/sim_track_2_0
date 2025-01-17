import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/flight_record_provider.dart';
import '../widgets/flight_record_tile.dart';

class FlightRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flightRecordProvider = Provider.of<FlightRecordProvider>(context);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Flight Record',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: flightRecordProvider.fetchFlightRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (flightRecordProvider.records.isEmpty) {
                return const Center(child: Text('No flight records found.'));
              } else {
                return ListView.builder(
                  itemCount: flightRecordProvider.records.length,
                  itemBuilder: (context, index) {
                    final record = flightRecordProvider.records[index];
                    return FlightRecordTile(
                      flight_crew_logo: record.flightCrewLogo,
                      flight_crew: record.flightCrew,
                      flight_date: record.flightDate,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
