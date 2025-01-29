import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sim_track_2_0/screens/sim_schedule_screen.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> _simulators = [];
  String? _selectedSimulator;

  @override
  void initState() {
    super.initState();
    _fetchSimulators();
  }

  Future<void> _fetchSimulators() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/api/simulators'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _simulators = data.map((sim) => sim['name'].toString()).toList();
          _selectedSimulator = _simulators.isNotEmpty ? _simulators.first : null;
        });
      } else {
        throw Exception('Failed to load simulators');
      }
    } catch (error) {
      print('Error fetching simulators: $error');
    }
  }

  void _navigateToSimSchedule() {
    if (_selectedSimulator != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SimScheduleScreen(selectedSimStr: _selectedSimulator!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            LogoWidget(
              imagePath: 'assets/images/sim_track_logo.png',
              title: 'SimTrack',
            ),

            const SizedBox(height: 20),

            // Dropdown Menu
            Text(
              _selectedSimulator ?? "Select a Simulator",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            DropdownButton<String>(
              value: _selectedSimulator,
              hint: const Text('Choose a Simulator'),
              onChanged: (newValue) {
                setState(() {
                  _selectedSimulator = newValue;
                });
              },
              items: _simulators.map((sim) {
                return DropdownMenuItem<String>(
                  value: sim,
                  child: Text(sim),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Continue Button
            ElevatedButton(
              onPressed: _selectedSimulator == null ? null : _navigateToSimSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Logo Widget
class LogoWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const LogoWidget({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white10,
          backgroundImage: AssetImage(imagePath),
          radius: size.height * 0.12,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
