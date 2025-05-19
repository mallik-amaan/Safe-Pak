import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/emergency_contact_detail_field.dart';

import '../../../../core/common/widgets/button_widget.dart';
import '../cubit/emergency_cubit.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  EmergencyDetailsScreen({super.key});
  final nameController = TextEditingController();
  final relationController = TextEditingController();
  final phoneNoController = TextEditingController();
  final GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Emergency Contacts",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Add trusted contacts for emergencies",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  EmergencyContactDetailField(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    icon: Icons.person,
                    controller: nameController,
                    label: "Contact Name",
                  ),
                  const SizedBox(height: 16),
                  EmergencyContactDetailField(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter a relationship';
                      }
                      return null;
                    },
                    icon: Icons.diversity_1,
                    controller: relationController,
                    label: "Relationship",
                  ),
                  const SizedBox(height: 16),
                  EmergencyContactDetailField(
                    validator: _validatePhoneNumber,
                    icon: Icons.phone,
                    controller: phoneNoController,
                    label: "Phone Number",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocConsumer<EmergencyCubit, EmergencyState>(
                    listener: (context, state) {
                      if (state is EmergencyContactAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Emergency contact added successfully!',
                            ),
                          ),
                        );
                        nameController.clear();
                        relationController.clear();
                        phoneNoController.clear();
                        context.go('/home');
                      } else if (state is EmergencyError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ButtonWidget(
                        onPressed: () {
                          final name = nameController.text.trim();
                          final relation = relationController.text.trim();
                          final phone = phoneNoController.text.trim();
                          if (name.isEmpty || relation.isEmpty || phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields')),
                            );
                            return;
                          }
                          context.read<EmergencyCubit>().addEmergencyContact(
                                EmergencyContactEntity(
                                  name: name,
                                  relation: relation,
                                  phoneNumber: phone,
                                  isPrimary: true,
                                ),
                              );
                        },
                        content: state is EmergencyLoading
                            ? const LoadingIndicator(
                                indicatorType: Indicator.ballBeat,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              )
                            : const Text("Add Contact"),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
