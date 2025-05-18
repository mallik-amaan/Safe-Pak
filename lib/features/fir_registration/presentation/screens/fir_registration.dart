import 'package:criminal_catcher/features/fir_registration/domain/data_sources/fir_remote_data_source.dart';
import 'package:criminal_catcher/features/fir_registration/presentation/widgets/action_button.dart';
import 'package:criminal_catcher/features/fir_registration/presentation/widgets/fir_text_field.dart';
import 'package:criminal_catcher/core/services/location_service.dart';
import 'package:criminal_catcher/injection.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FirRegistration extends StatefulWidget {
  const FirRegistration({super.key});

  @override
  _FirRegistrationState createState() => _FirRegistrationState();
}

class _FirRegistrationState extends State<FirRegistration> {
  String? _selectedType;
  late final _locationController;
  late final _dateTimeController;
  final List<DropdownMenuItem<String>> _complaintTypes = const [
    DropdownMenuItem(value: "theft", child: Text("Theft")),
    DropdownMenuItem(value: "assault", child: Text("Assault")),
    DropdownMenuItem(value: "fault", child: Text("Fault")),
    DropdownMenuItem(value: "robbery", child: Text("Robbery")),
    DropdownMenuItem(value: "other", child: Text("Other")),
  ];

  // Placeholder for file upload logic
  void _handleFileUpload() {
    // TODO: Implement file picker logic (e.g., using file_picker package)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("File upload functionality not implemented")),
    );
  }

  void initState(){
    super.initState();
    _locationController = TextEditingController();
    _dateTimeController = TextEditingController();
  }
  // Placeholder for form submission logic
  void _handleSubmit() {
    if (_selectedType == null) {
      // sl<FIRRemoteDataSource>().submitFIR(fir);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a complaint type")),
      );
      return;
    }
    // TODO: Implement form submission logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("FIR submitted successfully")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File FIR Report"),
        backgroundColor: Theme.of(context).highlightColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type of Complaint",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedType,
                hint: Text(
                  "Choose complaint type",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                items: _complaintTypes,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
                style: Theme.of(context).textTheme.bodyLarge,
                dropdownColor: Theme.of(context).cardColor,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              const FIRTextField(
                label: "Incident Description",
                icon: Icons.warning_amber_outlined,
                minLines: 5,
              ),
              const SizedBox(height: 16),
              FIRTextField(
                label: "Date",
                icon: Icons.date_range,
                controller: _dateTimeController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final fullDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      final formattedDateTime =
                      DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);

                      _dateTimeController.text = formattedDateTime;
                    }
                  }
                },

              ),

              const SizedBox(height: 16),
              FIRTextField(
                label: "Location",
                icon: Icons.location_on,
                controller: _locationController,
                readOnly: true,
                suffix:  Padding(
                  padding: const EdgeInsets.only(top: 0, right: 10),
                  child: Card(
                    child: IconButton(
                        onPressed: () async {
                          print("location button pressed");
                          await sl<LocationService>()
                              .getCurrentLocation()
                              .then((placemark) {
                            print("in then block");
                            if (placemark != null) {
                              _locationController.text = "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}";
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Location: ${placemark.locality}, ${placemark.country}",
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Unable to get location"),
                                ),
                              );
                            }
                          });
                        },
                        icon: Icon(Icons.my_location)),
                  ),
                )
              ),
              const SizedBox(height: 16),
              Text(
                "Upload Evidence (Optional)",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _handleFileUpload,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.drive_folder_upload_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 40,
                        ),
                        Text(
                          "Tap to upload photo or video",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ActionButton(context, "Submit", _handleSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
