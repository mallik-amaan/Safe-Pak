import 'package:flutter/material.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/action_button.dart';

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
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.local_police_sharp,
                    size: 40,
                    color: AppColors.secondaryColor,
                  ),
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
