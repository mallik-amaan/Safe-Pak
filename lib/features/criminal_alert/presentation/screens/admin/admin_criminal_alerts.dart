import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/action_button.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/admin/criminal_card.dart';

class AdminCriminalAlertsPage extends StatelessWidget {
  AdminCriminalAlertsPage({super.key});
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CriminalActionButton(
                          width: 200,
                          label: "Add new Criminal",
                          onPressed: () {
                            context.push("/criminal_alert/add_criminal_alert");
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: criminalAlerts.length,
                  itemBuilder: (context, index) {
                    return AdminCriminalCard(
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
