import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/flight_record_provider.dart';
import './screens/sim_schedule_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlightRecordProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimScheduleScreen(selectedSimStr: 'Simulator 1'),
    );
  }
}
