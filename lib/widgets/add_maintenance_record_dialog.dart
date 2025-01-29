import 'package:flutter/material.dart';
import 'package:sim_track_2_0/models/maintenance_record_model.dart';
class AddMaintenanceRecordDialog extends StatefulWidget {
  @override
  _AddMaintenanceRecordDialogState createState() =>
      _AddMaintenanceRecordDialogState();
}

class _AddMaintenanceRecordDialogState
    extends State<AddMaintenanceRecordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _aircraftNameController = TextEditingController();
  final _maintenanceTypeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  String _status = 'Pending';

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final maintenanceRecord = MaintenanceRecord(
        id: '',
        aircraftName: _aircraftNameController.text,
        maintenanceType: _maintenanceTypeController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        status: _status,
      );
      Navigator.of(context).pop(maintenanceRecord);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _aircraftNameController,
                decoration: const InputDecoration(labelText: 'Aircraft Name'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enter aircraft name' : null,
              ),
              TextFormField(
                controller: _maintenanceTypeController,
                decoration:
                const InputDecoration(labelText: 'Maintenance Type'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enter maintenance type' : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enter start date' : null,
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(labelText: 'End Date'),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enter end date' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                onChanged: (value) => setState(() => _status = value!),
                items: ['Pending', 'Completed']
                    .map((status) =>
                    DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Add Maintenance Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
