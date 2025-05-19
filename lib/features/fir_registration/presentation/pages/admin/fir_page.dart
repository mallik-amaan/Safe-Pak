import 'package:flutter/material.dart';
import 'package:safepak/features/fir_registration/presentation/widgets/admin/admin_fir_card.dart';

class AdminFIRPage extends StatelessWidget {
  AdminFIRPage({super.key});
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
          child: Center(
            child: Column(
              children: [
                Text(
                  "Registered FIRs",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text("View and manage registered FIRs",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: criminalAlerts.length,
                  itemBuilder: (context, index) {
                    return AdminFirCard(
                      label: criminalAlerts[index]["label"],
                      description: criminalAlerts[index]["description"],
                      location: criminalAlerts[index]["location"],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
