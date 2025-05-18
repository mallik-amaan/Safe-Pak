import 'package:flutter/material.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/emergency_contact_detail_field.dart';

class EmergencyDetailsScreen extends StatelessWidget {
  EmergencyDetailsScreen({super.key});
  final nameController = TextEditingController();
  final relationController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                "Emergency Contacts",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Add trusted contacts for emergencies",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                EmergencyContactDetailScreen(
                    icon: Icons.person,
                    controller: nameController,
                    label: "Contact Name"),
                const SizedBox(
                  height: 16,
                ),
                EmergencyContactDetailScreen(
                    icon: Icons.diversity_1,
                    controller: relationController,
                    label: "Relationship"),
                const SizedBox(
                  height: 16,
                ),
                EmergencyContactDetailScreen(
                    icon: Icons.phone,
                    controller: phoneNoController,
                    label: "Phone Number"),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).highlightColor,
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Save Emergency Contact",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
