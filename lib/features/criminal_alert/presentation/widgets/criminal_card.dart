import 'package:flutter/material.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/action_button.dart';
import 'package:safepak/features/fir_registration/presentation/widgets/action_button.dart';

class CriminalCard extends StatelessWidget {
  final String label;
  final String location;
  final String description;

  const CriminalCard({
    super.key,
    required this.label,
    required this.description,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image or avatar placeholder
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(width: 12),
                // Expanded column for texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        softWrap: true,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        softWrap: true,
                      ),
                      const SizedBox(height: 8),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CriminalActionButton(
                            label: "Report",
                            onPressed: () {
                              // Handle share action
                            },
                            color: Colors.grey.shade200,
                            textColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 16),
                          CriminalActionButton(
                            label: "Share",
                            onPressed: () {
                              // Handle report action
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
