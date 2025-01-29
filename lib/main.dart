import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sim_track_2_0/providers/simulator_provider.dart';
import 'package:sim_track_2_0/screens/landing_screen.dart';
import './providers/flight_record_provider.dart';
import './screens/sim_schedule_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FlightRecordProvider()),
        ChangeNotifierProvider(create: (_) => SimulatorProvider()), // Add Simulator Provider
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
      home: LandingPage(),
      //home: SimScheduleScreen(selectedSimStr: 'Simulator 1'),
    );
  }
}
