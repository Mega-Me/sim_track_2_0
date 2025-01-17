import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sim_track_2_0/widgets/flight_record_tile.dart';
import 'package:sim_track_2_0/widgets/sidebar_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/flight_record_provider.dart';
import '../widgets/flight_record_tile.dart';

Future<List<dynamic>> fetchFlightRecords() async {
  final response =
      await http.get(Uri.parse('http://localhost:5000/api/flight-records'));

  if (response.statusCode == 200) {
    print(response.body);
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load flight records');
  }
}

class SimScheduleScreen extends StatefulWidget {
  final String selectedSimStr;

  const SimScheduleScreen({super.key, required this.selectedSimStr});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<SimScheduleScreen> {
  late String selectedSim = widget.selectedSimStr;
  late String _time;
  late String _date;
  late Widget _currentContent;
  String _selectedButton = "Sim Schedule"; // Keeps track of the selected button

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _currentContent = SimScheduleContent(); // Default screen
    Future.delayed(Duration.zero, () {
      _updateClock();
    });
    fetchFlightRecords();
  }

  void _updateDateTime() {
    DateTime now = DateTime.now();
    _time = DateFormat('hh:mm:ss a').format(now);
    _date = DateFormat('EEEE, dd MMM yyyy').format(now);
  }

  void _updateClock() {
    setState(() {
      _updateDateTime();
    });
    Future.delayed(const Duration(seconds: 1), _updateClock);
  }

  void _changeContent(String buttonName, Widget newContent) {
    setState(() {
      _selectedButton = buttonName; // Update the selected button
      _currentContent = newContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          // Sidebar
          Container(
            width: size.width * 0.2,
            padding: EdgeInsets.all(size.height * 0.02),
            margin: EdgeInsets.all(size.height * 0.02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.height * 0.02),
            ),
            child: Column(
              children: [
                LogoWidget(
                  imagePath: 'assets/images/sim_track_logo.png',
                  title: 'SimTrack',
                ),
                Padding(
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Text(
                    selectedSim,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Sidebar buttons with state management
                SidebarButton(
                  label: "Sim Schedule",
                  isHighlighted: _selectedButton == "Sim Schedule",
                  onPressed: () =>
                      _changeContent("Sim Schedule", SimScheduleContent()),
                ),
                SidebarButton(
                  label: "Flight Record",
                  isHighlighted: _selectedButton == "Flight Record",
                  onPressed: () =>
                      _changeContent("Flight Record", FlightRecordContent()),
                ),
                SidebarButton(
                  label: "Maintenance Record",
                  isHighlighted: _selectedButton == "Maintenance Record",
                  onPressed: () => _changeContent(
                      "Maintenance Record", MaintenanceRecordContent()),
                ),
                SidebarButton(
                  label: "Sim Advisory",
                  isHighlighted: _selectedButton == "Sim Advisory",
                  onPressed: () =>
                      _changeContent("Sim Advisory", SimAdvisoryContent()),
                ),
                SidebarButton(
                  label: "Certificates",
                  isHighlighted: _selectedButton == "Certificates",
                  onPressed: () =>
                      _changeContent("Certificates", CertificatesContent()),
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                Container(
                  height: size.height * 0.13,
                  padding: EdgeInsets.all(size.height * 0.01),
                  margin: EdgeInsets.only(
                      right: size.height * 0.02,
                      top: size.height * 0.02,
                      bottom: size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(size.height * 0.02),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Clock and Date
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _time,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _date,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Notification Icons
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.settings_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right: size.height * 0.02, bottom: size.height * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.02),
                    ),
                    child: _currentContent,
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

// Content Widgets for Each Screen
class SimScheduleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Sim Schedule Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FlightRecordContent extends StatefulWidget {
  @override
  _FlightRecordContentState createState() => _FlightRecordContentState();
}

class _FlightRecordContentState extends State<FlightRecordContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    try {
      await Provider.of<FlightRecordProvider>(context, listen: false)
          .fetchFlightRecords();
    } catch (error) {
      print("Error loading data: $error");
    }
  }

  Future<void> _showAddFlightDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: AddFlightRecordDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final flightRecordProvider = Provider.of<FlightRecordProvider>(context);
    final records = flightRecordProvider.records;

    return Scaffold(
      body: Column(
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
            child: records.isEmpty
                ? const Center(child: Text('No flight records found.'))
                : ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return FlightRecordTile(
                        flight_crew_logo: record.flightCrewLogo,
                        flight_crew: record.flightCrew,
                        flight_date: record.flightDate,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFlightDialog,
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.flight,
          size: 32,
        ),
        tooltip: 'Add Flight Record',
      ),
    );
  }
}

class AddFlightRecordDialog extends StatefulWidget {
  @override
  _AddFlightRecordDialogState createState() => _AddFlightRecordDialogState();
}

class _AddFlightRecordDialogState extends State<AddFlightRecordDialog> {
  final _formKey = GlobalKey<FormState>();

  final _crewController = TextEditingController();
  final _dateController = TextEditingController();
  final _instructorName1Controller = TextEditingController();
  final _instructorReg1Controller = TextEditingController();
  final _instructorName2Controller = TextEditingController();
  final _instructorReg2Controller = TextEditingController();
  final _traineeName1Controller = TextEditingController();
  final _traineeReg1Controller = TextEditingController();
  final _traineeName2Controller = TextEditingController();
  final _traineeReg2Controller = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:5000/api/flight-records'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "flightCrew": _crewController.text,
            "flightDate": _dateController.text,
            "instructor1": {
              "name": _instructorName1Controller.text,
              "reg": _instructorReg1Controller.text,
            },
            "instructor2": {
              "name": _instructorName2Controller.text,
              "reg": _instructorReg2Controller.text,
            },
            "trainee1": {
              "name": _traineeName1Controller.text,
              "reg": _traineeReg1Controller.text,
            },
            "trainee2": {
              "name": _traineeName2Controller.text,
              "reg": _traineeReg2Controller.text,
            },
            "startTime": _startTimeController.text,
            "endTime": _endTimeController.text,
          }),
        );

        if (response.statusCode == 201) {
          Navigator.of(context).pop(); // Close dialog
        } else {
          throw Exception('Failed to add flight record');
        }
      } catch (error) {
        print("Error adding flight record: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.01,
                      vertical: size.height * 0.02),
                  child: Center(
                    child: const Text(
                      'Add Flight Record',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: Flight Crew and Flight Date
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTextField(
                              'Flight Crew',
                              _crewController,
                            ),
                            const SizedBox(height: 16),
                            _buildDateField('Flight Date', _dateController),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Column 2: Instructors and Trainees
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Column(
                          children: [
                            _buildRowFields(
                              'Instructor Name 1',
                              _instructorName1Controller,
                              'Instructor ID 1',
                              _instructorReg1Controller,
                            ),
                            const SizedBox(height: 16),
                            _buildRowFields(
                              'Instructor Name 2',
                              _instructorName2Controller,
                              'Instructor ID 2',
                              _instructorReg2Controller,
                            ),
                            const SizedBox(height: 16),
                            _buildRowFields(
                              'Trainee Name 1',
                              _traineeName1Controller,
                              'Trainee ID 1',
                              _traineeReg1Controller,
                            ),
                            const SizedBox(height: 16),
                            _buildRowFields(
                              'Trainee Name 2',
                              _traineeName2Controller,
                              'Trainee ID 2',
                              _traineeReg2Controller,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Column 3: Start and End Time
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size.height * 0.38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(size.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildTimeField('Start Time', _startTimeController),
                            const SizedBox(height: 16),
                            _buildTimeField('End Time', _endTimeController),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Cancel'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white24,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 12.0,
                                    ),
                                  ),
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please enter $label' : null,
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please select $label' : null,
    );
  }

  Widget _buildRowFields(
    String label1,
    TextEditingController controller1,
    String label2,
    TextEditingController controller2,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(label1, controller1),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(label2, controller2),
        ),
      ],
    );
  }

  Widget _buildTimeField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          final now = DateTime.now();
          final time = DateTime(
            now.year,
            now.month,
            now.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          controller.text = DateFormat('HH:mm').format(time);
        }
      },
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please select $label' : null,
    );
  }
}

class MaintenanceRecordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Maintenance Record Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class SimAdvisoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Sim Advisory Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CertificatesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Certificates Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
