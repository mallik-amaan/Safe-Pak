import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';

class CreateAccountPage1 extends StatefulWidget {
  const CreateAccountPage1({super.key});

  @override
  _CreateAccountPage1State createState() => _CreateAccountPage1State();
}

class _CreateAccountPage1State extends State<CreateAccountPage1> {
  final _phoneController = TextEditingController();
  final _dobController = TextEditingController();
  String? _selectedGender;
  File? _profileImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final List<String> _genders = ['Male', 'Female', 'Other'];
  late UserEntity prevUser;


  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    // Check for exactly 11 digits
    final regex = RegExp(r'^\d{11}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid 11-digit phone number';
    }
    return null;
  }

  Future<void> _pickImage(String source) async {
    final pickedFile = await _picker.pickImage(source: source == 'gallery'?ImageSource.gallery:ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    prevUser = GoRouter.of(context).state.extra as UserEntity;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                    GestureDetector(
                    onTap: () async {
                      showDialog(
                      context: context,
                        builder: (context) => SimpleDialog(
                        title: const Text('Select Image Source',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                               SizedBox(height: 20),
                              ButtonWidget(
                                content: Text('Camera', style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                Navigator.of(context).pop();
                                _pickImage('camera');
                                },
                              ),
                              const SizedBox(height: 10),
                              ButtonWidget(
                                content: Text('Gallery', style: TextStyle(color: Colors.white)),
                                onPressed: () async {
                                Navigator.of(context).pop();
                                _pickImage('gallery');
                                },
                              ),
                            ],
                            ),
                          ),
                        ],
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightGrey,
                      backgroundImage:
                        _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                        ? const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.primaryColor,
                        )
                        : null,
                    ),
                    ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    cursorColor: AppColors.primaryColor,
                    validator: _validatePhoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: const Icon(
                        Icons.phone,
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
                    controller: _dobController,
                    readOnly: true,
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      hintText: 'Date of Birth (DD/MM/YYYY)',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: AppColors.secondaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    hint: const Text('Select Gender'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                    items: _genders
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
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
                  const SizedBox(height: 20),
                  ButtonWidget(
                    content: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        UserEntity user = prevUser.copyWith(
                          phoneNumber: _phoneController.text,
                            dob: _dobController.text,
                            image: _profileImage,
                            gender: _selectedGender, 
                        );
                        context.push('/create_account_page_1/create_account_page_2',
                          extra: user
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}