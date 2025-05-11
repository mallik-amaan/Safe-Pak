import 'package:criminal_catcher/FIR%20Registration/crime_reporting_screen.dart';
import 'package:criminal_catcher/FIR%20Registration/fir_registration.dart';
import 'package:flutter/material.dart';

List<Widget> HomeCards(BuildContext context) {
  final Map<String, dynamic> comps = {
    "FIR": {
      "title": "File FIR",
      "description": "Report an Incident",
      "icon": "assets/icon/fir.png"
    },
    "Alerts": {
      "title": "Alerts",
      "description": "View nearby alerts",
      "icon": "assets/icon/alerts.png"
    },
    "Emergency": {
      "title": "Emergency",
      "description": "Quick Assistance",
      "icon": "assets/icon/emergency.png"
    }
  };

  return comps.entries.map((entry) {
    final item = entry.value;
    return GestureDetector(
      onTap: () {
        if (entry.key == "FIR") {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => CrimeReportingScreen()));
        } else if (entry.key == "Emergency") {
        } else if (entry.key == "Alerts") {}
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        shadowColor: Theme.of(context).shadowColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 200,
            width: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Image.asset(
                    item['icon'],
                    height: 25,
                    width: 25,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item['title'],
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  item['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }).toList();
}
