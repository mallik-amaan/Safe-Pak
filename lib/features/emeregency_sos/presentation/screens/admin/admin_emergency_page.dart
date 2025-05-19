import 'package:flutter/material.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/admin/alert_card.dart';

class AdminEmergencyPage extends StatelessWidget {
  AdminEmergencyPage({super.key});
  final List<Map<String, dynamic>> criminalAlerts = [
    {
      "label": "Ali Ahmed",
      "location": "Attar Hostel",
      "description": "03112255664",
    },
    {
      "label": "Anonymous",
      "location": "Near Central Park",
      "description": "123456789",
    },
    {
      "label": "Disabled Person",
      "location": "Near Central Park",
      "description": "123456789",
    },
    {
      "label": "Unknowm Person",
      "location": "Near Central Park",
      "description": "123456789"
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
                  "Emergency Alerts",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text("Nearby emergency calls",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: criminalAlerts.length,
                  itemBuilder: (context, index) {
                    return AlertCard(
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
