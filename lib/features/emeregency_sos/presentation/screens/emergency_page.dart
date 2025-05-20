import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/core/services/location_service.dart';
import 'package:safepak/core/services/send_sms_service.dart';
import 'package:safepak/features/emeregency_sos/presentation/cubit/emergency_cubit.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/emergency_contact_tile.dart';

import '../../../../core/services/shake_detector_service.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  late EmergencyShakeDetector _detector;
  bool _isShakeDetectionEnabled = false;
  late List phoneNumberList = [];
  @override
  void initState() {
    super.initState();
    context.read<EmergencyCubit>().getEmergencyContacts();
    _detector = EmergencyShakeDetector(
        shakeThreshold: 3,
        onShake: () {
          if (_isShakeDetectionEnabled) _triggerEmergency();
        });
    _detector.startListening();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _triggerEmergency() async {
    if (phoneNumberList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Phone numbers in the list")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Emergency action triggered!")),
    );
    LocationService locationService = LocationService();
    var position = await locationService.getCurrentPosition();
    for (var phoneNumber in phoneNumberList) {
      await sendSmsAutomatically(
        phoneNumber,
        "Emergency! Please help! My location is: https://www.google.com/maps/search/?api=1&query=${position?.latitude},${position?.longitude}",
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Emergency action completed!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Emergency Mode",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "Quick access to emergency services",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Shake Device or Press Button",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Triple shake your device or press and hold the emergency button to trigger alert",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onLongPress: _triggerEmergency,
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Press and hold for emergency",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SwitchListTile(
                tileColor: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                value: _isShakeDetectionEnabled,
                onChanged: (value) {
                  setState(() {
                    _isShakeDetectionEnabled = value;
                  });
                },
                title: const Text("Shake Detection"),
                subtitle: const Text("Triple shake to trigger emergency"),
                secondary: const Icon(Icons.vibration),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text(
                    "Emergency Contacts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the emergency contacts screen
                      context.push('/emergency/emergency_details');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Add new",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<EmergencyCubit, EmergencyState>(
                builder: (context, state) {
                  if (state is EmergencyLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.secondaryColor,
                    ));
                  } else if (state is EmergencyContactsLoaded) {
                    phoneNumberList = state.contacts
                        .map((contact) => contact.phoneNumber)
                        .toList();
                    if (state.contacts.isEmpty) {
                      return const Center(
                        child: Text("No emergency contacts added yet."),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.contacts.length,
                      itemBuilder: (context, index) {
                        return EmergencyContactTile(
                          name: state.contacts[index].name!,
                          phoneNumber: state.contacts[index].phoneNumber!,
                          relation: state.contacts[index].relation!,
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Contact'),
                                content: const Text(
                                    'Are you sure you want to delete this emergency contact?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<EmergencyCubit>()
                                          .deleteContact(state.contacts[index]);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Delete',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is EmergencyError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
