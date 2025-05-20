import 'package:flutter/material.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/admin/action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class AlertCard extends StatelessWidget {
  final String label;
  final String location;
  final String description;

  const AlertCard({
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
                              Row(
                                children: [
                                  Text(
                                    "location",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse(
                                          location);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,
                                            mode:
                                                LaunchMode.externalApplication);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text("Could not launch map")),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.location_on),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 4),
                            ],
                          )),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          AlertActionButton(
                            label: "Take Action",
                            onPressed: () {
                              // Show the take action dialog
                              takeActionDialog(context);
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                          ),
                          const SizedBox(width: 16),
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
