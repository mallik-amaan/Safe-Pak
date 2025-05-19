import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

List<Widget> homeCards(BuildContext context) {
  final Map<String, dynamic> comps = {
    "FIR": {
      "title": "File FIR",
      "description": "Report an Incident",
      "icon": AntDesign.file_text_outline,
    },
    "Alerts": {
      "title": "Alerts",
      "description": "View nearby alerts",
      "icon": Icons.warning_amber_outlined,
    },
    "Emergency": {
      "title": "Emergency",
      "description": "Quick Assistance",
      "icon": Icons.local_police,
    }
  };

  return comps.entries.map((entry) {
    final item = entry.value;
    return GestureDetector(
      onTap: () {
        if (entry.key == "FIR") {
          context.push('/fir_registration');
        } else if (entry.key == "Emergency") {
         context.push('/emergency');
        } else if (entry.key == "Alerts") {
          context.push('/criminal_alert');
        }
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
                  child: Icon(
                    item['icon'],
                    color: Colors.white,
                    size: 30,
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
