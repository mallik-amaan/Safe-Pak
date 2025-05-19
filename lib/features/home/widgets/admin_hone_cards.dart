import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

List<Widget> AdminHomeCards(BuildContext context) {
  final Map<String, dynamic> comps = {
    "FIR": {
      "title": "FIR Reports",
      "description": "Report an Incident",
      "icon": AntDesign.file_text_outline,
    },
    "Alerts": {
      "title": "Manage Alerts",
      "description": "View nearby alerts",
      "icon": Icons.warning_amber_outlined,
    },
    "Emergency": {
      "title": "Emergency Services",
      "description": "Quick Assistance",
      "icon": Icons.local_police,
    }
  };

  return comps.entries.map((entry) {
    final item = entry.value;
    return GestureDetector(
      onTap: () {
        if (entry.key == "FIR") {
          context.push('/admin_fir');
        } else if (entry.key == "Emergency") {
          context.push('/admin_emergency');
        } else if (entry.key == "Alerts") {
          context.push('/admin_alert');
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
                  textAlign: TextAlign.center,
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
