import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:safepak/features/fir_registration/presentation/widgets/action_button.dart';
import 'package:safepak/features/fir_registration/presentation/widgets/fir_text_field.dart';
import 'package:safepak/core/services/location_service.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/fir_bloc.dart';
import '../bloc/fir_event.dart';
import '../bloc/fir_state.dart';

class FirRegistration extends StatelessWidget {
  const FirRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FIRBloc>(),
      child: const _FirRegistrationContent(),
    );
  }
}

class _FirRegistrationContent extends StatefulWidget {
  const _FirRegistrationContent();

  @override
  _FirRegistrationContentState createState() => _FirRegistrationContentState();
}

class _FirRegistrationContentState extends State<_FirRegistrationContent> {
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateTimeController = TextEditingController();
  String? _selectedType;

  final List<DropdownMenuItem<String>> _complaintTypes = const [
    DropdownMenuItem(value: "theft", child: Text("Theft")),
    DropdownMenuItem(value: "assault", child: Text("Assault")),
    DropdownMenuItem(value: "fault", child: Text("Fault")),
    DropdownMenuItem(value: "robbery", child: Text("Robbery")),
    DropdownMenuItem(value: "other", child: Text("Other")),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with BLoC state
    final state = context.read<FIRBloc>().state;
    _descriptionController.text = state.description;
    _locationController.text = state.location;
    _dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(state.dateTime);
    _selectedType = state.complaintType.isNotEmpty ? state.complaintType : null;

    // Dispatch description changes to BLoC
    _descriptionController.addListener(() {
      context.read<FIRBloc>().add(FIRDescriptionChanged(_descriptionController.text));
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  // Future<void> _handleFileUpload() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     allowMultiple: true,
  //     type: FileType.media, // Restrict to images and videos
  //   );
  //   if (result != null && result.files.isNotEmpty) {
  //     final paths = result.files.map((file) => file.path!).toList();
  //     context.read<FIRBloc>().add(FIREvidenceAdded(paths));
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Evidence uploaded successfully")),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("No files selected")),
  //     );
  //   }
  // }

  void _handleSubmit() {
    if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a complaint type")),
      );
      return;
    }
    context.read<FIRBloc>().add(FIRSubmitRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FIRBloc, FIRState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('FIR submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<FIRBloc>().add(ResetFIRFeedback());
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
          context.read<FIRBloc>().add(ResetFIRFeedback());
        }
      },
      builder: (context, state) {
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
                      context.read<FIRBloc>().add(FIRComplaintTypeChanged(value ?? ''));
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
                  FIRTextField(
                    label: "Incident Description",
                    icon: Icons.warning_amber_outlined,
                    minLines: 5,
                    controller: _descriptionController,
                    enabled: !state.isSubmitting,
                  ),
                  const SizedBox(height: 16),
                  FIRTextField(
                    label: "Date",
                    icon: Icons.date_range,
                    controller: _dateTimeController,
                    readOnly: true,
                    enabled: !state.isSubmitting,
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
                          _dateTimeController.text =
                              DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);
                          // Note: Not dispatching date change as FIRState uses DateTime.now() by default
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
                    enabled: !state.isSubmitting,
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Card(
                        child: IconButton(
                          onPressed: state.isSubmitting
                              ? null
                              : () async {
                            await sl<LocationService>().getCurrentLocation().then((placemark) {
                              if (placemark != null) {
                                final location =
                                    "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}";
                                _locationController.text = location;
                                context.read<FIRBloc>().add(FIRLocationChanged(location));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Location: ${placemark.locality}, ${placemark.country}",
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Unable to get location")),
                                );
                              }
                            });
                          },
                          icon: const Icon(Icons.my_location),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Upload Evidence (Optional)",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: state.isSubmitting ? null : (){},//_handleFileUpload,
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
                            if (state.evidencePaths.isNotEmpty)
                              Text(
                                "${state.evidencePaths.length} file(s) uploaded",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ActionButton(
                    context,
                    state.isSubmitting ? "Submitting..." : "Submit",
                    (state.isSubmitting ? null : _handleSubmit) as Function,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}