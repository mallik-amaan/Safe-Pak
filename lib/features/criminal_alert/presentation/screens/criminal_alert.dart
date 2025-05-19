import 'package:flutter/material.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/criminal_card.dart';

class CriminalAlertPage extends StatelessWidget {
  CriminalAlertPage({super.key});
  final List<Map<String, dynamic>> criminalAlerts = [
    {
      "label": "Armed Robbery Suspect",
      "location": "Attar Hostel",
      "description": "Last seen near Central Market wearing black jacket",
    },
    {
      "label": "Suspicious Person",
      "location": "Near Central Park",
      "description":
          "Last seen near Central Park wearing a red cap and black pants",
    },
    {
      "label": "Suspicious Person",
      "location": "Near Central Park",
      "description":
          "Last seen near Central Park wearing a red cap and black pants",
    },
    {
      "label": "Suspicious Person",
      "location": "Near Central Park",
      "description":
          "Last seen near Central Park wearing a red cap and black pants",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Criminal Alerts",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text("Nearby suspicious activities",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: criminalAlerts.length,
                  itemBuilder: (context, index) {
                    return CriminalCard(
                      label: criminalAlerts[index]["label"],
                      description: criminalAlerts[index]["description"],
                      location: criminalAlerts[index]["location"],
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
