import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmergencyContactTile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String relation;
  const EmergencyContactTile({
    super.key,
    this.name = "John Doe",
    this.phoneNumber = "1234567890",
    this.relation = "Father",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        color: Colors.grey.shade200,
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(name),
          trailing: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.call,
                    size: 15,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Phone No:",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(phoneNumber, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
            ],
          ),
          subtitle: Text(relation),
          onTap: () {
            print("Tapped on John Doe");
          },
        ),
      ),
    );
  }
}
