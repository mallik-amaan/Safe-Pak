import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safepak/core/services/location_service.dart';
import 'package:safepak/core/services/send_sms_service.dart';
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
  @override
  void initState() {
    super.initState();
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Emergency action triggered!")),
    );
    LocationService locationService = LocationService();
    var position = await locationService.getCurrentPosition();
    await sendSmsAutomatically(
      "1234567890",
      "Emergency! Please help! My location is: https://www.google.com/maps/search/?api=1&query=${position?.latitude},${position?.longitude}",
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Emergency action completed`!")),
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
            Text(
              "Emergency Contacts",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            EmergencyContactTile(
              name: "Amaan",
              relation: "Father",
              phoneNumber: "1234567890",
            ),
            TextButton(
              child: Text("Edit Emergency Contacts"),
              onPressed: () {
                // Navigate to the emergency contacts screen
                context.push('/emergency/emergency_details');
              },
            )
          ],
        ),
      ),
    );
  }
}
