import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';
import 'package:safepak/features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';

class CreateAccountPage2 extends StatefulWidget {
  const CreateAccountPage2({
    super.key,
  });

  @override
  _CreateAccountPage2State createState() => _CreateAccountPage2State();
}

class _CreateAccountPage2State extends State<CreateAccountPage2> {
  final _addressController = TextEditingController();
  String? _selectedProvince;
  String? _selectedCity;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserEntity prevUser;

  @override
  void initState() {
    prevUser = GoRouter.of(context).state.extra as UserEntity;
    super.initState();
  }

  final List<String> _provinces = [
    'Punjab',
    'Sindh',
    'Khyber Pakhtunkhwa',
    'Balochistan',
    'Gilgit-Baltistan',
    'Islamabad Capital Territory',
  ];

  final Map<String, List<String>> _cities = {
    'Punjab': [
      'Lahore',
      'Faisalabad',
      'Rawalpindi',
      'Gujranwala',
      'Multan',
      'Sialkot',
      'Bahawalpur',
      'Sargodha',
      'Mianwali',
      'Dera Ghazi Khan',
      'Kasur',
      'Okara',
      'Jhang',
      'Toba Tek Singh',
      'Rahim Yar Khan',
      'Sheikhupura',
      'Attock',
      'Narowal',
      'Layyah',
      'Bhakkar',
      'Chiniot',
      'Pakpattan',
      'Vehari',
    ],
    'Sindh': [
      'Karachi',
      'Hyderabad',
      'Sukkur',
      'Larkana',
      'Nawabshah',
      'Mirpurkhas',
      'Thatta',
      'Dadu',
      'Badin',
      'Jacobabad',
      'Shikarpur',
    ],
    'Khyber Pakhtunkhwa': [
      'Peshawar',
      'Abbottabad',
      'Mardan',
      'Swat',
      'Kohat',
      'Dera Ismail Khan',
      'Bannu',
      'Nowshera',
      'Charsadda',
    ],
    'Balochistan': [
      'Quetta',
      'Gwadar',
      'Turbat',
      'Chaman',
      'Zhob',
      'Sibi',
      'Loralai',
      'Khuzdar',
      'Panjgur',
      'Naseerabad',
      'Dera Murad Jamali',
      'Jaffarabad',
      'Lasbela',
      'Kalat',
      'Awaran',
      'Kharan',
    ],
    'Gilgit-Baltistan': [
      'Gilgit',
      'Skardu',
      'Chilas',
      'Hunza',
      'Ghizer',
      'Ghanche',
      'Diamer',
      'Shigar',
      'Astore',
    ],
    'Islamabad Capital Territory': ['Islamabad'],
  };

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
                  const Text(
                    'Enter Your Address',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedProvince,
                    hint: const Text('Select Province'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a province';
                      }
                      return null;
                    },
                    items: _provinces
                        .map((province) => DropdownMenuItem(
                              value: province,
                              child: Text(province),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                        _selectedCity =
                            null; // Reset city when province changes
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
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    hint: const Text('Select City'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a city';
                      }
                      return null;
                    },
                    items: ((_selectedProvince != null
                                ? _cities[_selectedProvince]
                                : []) ??
                            <String>[])
                        .map((city) => DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value;
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
                    controller: _addressController,
                    cursorColor: AppColors.primaryColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText:
                          'Detailed Address (e.g., House No. 56-A, Sector H-9)',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AuthenticationCubit, AuthenticationState>(
                    listener: (context, state) {
                      if (state is UserUpdated) {
                        context.go(
                          '/success',
                        );
                        Fluttertoast.showToast(
                          msg: "Account created successfully!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      if (state is AuthenticationError) {
                        Fluttertoast.showToast(
                          msg: state.message.message,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidget(
                        content: state is AuthenticationLoading
                            ? const Center(
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [Colors.white],
                                  strokeWidth: 10,
                                ),
                              )
                            : const Text(
                                "Finish",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthenticationCubit>().updateUser(
                                  user: prevUser.copyWith(
                                    province: _selectedProvince!,
                                    city: _selectedCity!,
                                    address: _addressController.text.trim(),
                                  ),
                                );
                          }
                        },
                      );
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
