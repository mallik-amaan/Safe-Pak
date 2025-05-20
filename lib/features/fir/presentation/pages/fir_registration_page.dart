import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/core/services/location_service.dart';
import 'package:safepak/core/services/user_singleton.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';
import 'package:safepak/features/fir/presentation/cubit/fir_cubit.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../domain/entities/fir_entity.dart';

class FirRegistrationPage extends StatefulWidget {
  const FirRegistrationPage({super.key});

  @override
  State<FirRegistrationPage> createState() => _FirRegistrationPageState();
}


class _FirRegistrationPageState extends State<FirRegistrationPage> {
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateTimeController = TextEditingController();
  String? _selectedType;
  List<String> _evidencePaths = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    _dateTimeController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  Future<void> _handleFileUpload() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.media,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _evidencePaths = result.files.map((file) => file.path!).toList();
      });
      Fluttertoast.showToast(
        msg: "${_evidencePaths.length} file(s) uploaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "No files selected",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
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
      }
    }
  }

  void _handleSubmit() {
    UserEntity user = UserSingleton().user!;
    final FIREntity fir = FIREntity(
      complaintType: _selectedType!,
      description: _descriptionController.text,
      location: _locationController.text,
      dateTime: DateTime.parse(_dateTimeController.text.replaceAll(' ', 'T')),
      evidencePaths: _evidencePaths,
      userId: user.uid,
      userName: user.name,
      userEmail: user.email,
      userPhone: user.phoneNumber,
      status: "pending",
    );
    context.read<FirCubit>().submitFir(fir);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirCubit, FirState>(
      listener: (context, state) {
        if (state is FirSubmitted) {
          Fluttertoast.showToast(
            msg: "FIR submitted successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.go('/home');
        } else if (state is FirError) {
          Fluttertoast.showToast(
            msg: "Error: ${state.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        final isSubmitting = state is FirLoading;
        return Scaffold(
          appBar: AppBar(
            title: const Text("File FIR Report"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a complaint type';
                        }
                        return null;
                      },
                      value: _selectedType,
                      hint: const Text('Select Complaint Type'),
                      items: _complaintTypes,
                      onChanged: isSubmitting
                          ? null
                          : (value) {
                              setState(() {
                                _selectedType = value;
                              });
                            },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      controller: _descriptionController,
                      minLines: 5,
                      maxLines: 5,
                      enabled: !isSubmitting,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        prefixIcon: const Icon(
                          Icons.warning_amber_outlined,
                          color: AppColors.secondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date and time';
                        }
                        return null;
                      },
                      controller: _dateTimeController,
                      readOnly: true,
                      enabled: !isSubmitting,
                      cursorColor: AppColors.primaryColor,
                      onTap: () => _selectDateTime(context),
                      decoration: InputDecoration(
                        hintText: 'Date and Time',
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        prefixIcon: const Icon(
                          Icons.date_range,
                          color: AppColors.secondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a location';
                        }
                        return null;
                      },
                      controller: _locationController,
                      readOnly: true,
                      enabled: !isSubmitting,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Location',
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: AppColors.secondaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: isSubmitting
                              ? null
                              : () async {
                                  final placemark = await sl<LocationService>()
                                      .getCurrentLocation();
                                  if (placemark != null) {
                                    final location =
                                        "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}";
                                    _locationController.text = location;
                                    Fluttertoast.showToast(
                                      msg:
                                          "Location: ${placemark.locality}, ${placemark.country}",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: AppColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Unable to get location",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                          icon: const Icon(Icons.my_location),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: isSubmitting ? null : _handleFileUpload,
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.drive_folder_upload_rounded,
                                color: AppColors.primaryColor,
                                size: 40,
                              ),
                              const Text(
                                "Tap to upload photo or video",
                                style: TextStyle(fontSize: 16),
                              ),
                              if (_evidencePaths.isNotEmpty)
                                Text(
                                  "${_evidencePaths.length} file(s) uploaded",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget(
                      content: state is FirLoading
                          ? const Center(
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                colors: [Colors.white],
                                strokeWidth: 10,
                              ),
                            )
                          : const Text(
                              "Submit",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                      onPressed: () {
                        if (isSubmitting) return;
                        if (_formKey.currentState?.validate() == true) {
                          _handleSubmit();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
