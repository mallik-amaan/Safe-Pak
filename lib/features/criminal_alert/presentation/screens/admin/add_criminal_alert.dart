import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/core/services/location_service.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/features/criminal_alert/presentation/cubit/alert_cubit.dart';

import '../../../domain/entities/criminal_alert_entity.dart';

class AddCriminalAlert extends StatefulWidget {
  const AddCriminalAlert({super.key});

  @override
  State<AddCriminalAlert> createState() => _AddCriminalAlertState();
}

class _AddCriminalAlertState extends State<AddCriminalAlert> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _cityController = TextEditingController();
  final _dateTimeController = TextEditingController();
  List<String> _imagePaths = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _dateTimeController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _cityController.dispose();
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
        _imagePaths = result.files.map((file) => file.path!).toList();
      });
      Fluttertoast.showToast(
        msg: "${_imagePaths.length} file(s) selected",
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
    final alert = CriminalAlertEntity(
      id: '', // ID generated in AlertCubit
      title: _titleController.text,
      description: _descriptionController.text,
      images: _imagePaths,
      city: _cityController.text,
      createdAt: DateTime.parse(_dateTimeController.text.replaceAll(' ', 'T')),
    );
    context.read<AlertCubit>().createAlert(alert);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlertCubit, AlertState>(
      listener: (context, state) {
        if (state is AlertAdded) {
          Fluttertoast.showToast(
            msg: "Criminal alert submitted successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.go('/admin_home');
        } else if (state is AlertError) {
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
        final isSubmitting = state is AlertLoading;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Criminal Alert',
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      controller: _titleController,
                      enabled: !isSubmitting,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: 'Alert Title',
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        prefixIcon: const Icon(
                          Icons.title,
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
                          Icons.description,
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
                          return 'Please select a city';
                        }
                        return null;
                      },
                      controller: _cityController,
                      readOnly: true,
                      enabled: !isSubmitting,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: 'City',
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        prefixIcon: const Icon(
                          Icons.location_city,
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
                                    final city = placemark.locality ?? 'Unknown';
                                    _cityController.text = city;
                                    Fluttertoast.showToast(
                                      msg: "City: $city",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: AppColors.primaryColor,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: "Unable to get city",
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
                              if (_imagePaths.isNotEmpty)
                                Text(
                                  "${_imagePaths.length} file(s) selected",
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
                      content: state is AlertLoading
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