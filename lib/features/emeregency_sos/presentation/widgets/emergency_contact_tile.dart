import 'package:flutter/material.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';

class EmergencyContactTile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String relation;
  final GestureLongPressCallback onLongPress;
  const EmergencyContactTile({
    super.key,
    this.name = "John Doe", 
    this.phoneNumber = "1234567890",
    this.relation = "Father",
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      color: AppColors.lightGrey, // Use AppColors for consistency
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        // Wrap ListTile in InkWell for custom splash color
        splashColor: AppColors.primaryColor.withOpacity(0.2),
        highlightColor: AppColors.primaryColor.withOpacity(0.1),
        onLongPress: onLongPress,
        child: ListTile(
          leading: const Icon(
            Icons.person,
            color: AppColors.secondaryColor,
          ),
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.call,
                    size: 15,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Phone No:",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                phoneNumber,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                    ),
              ),
            ],
          ),
          subtitle: Text(
            relation,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ),
      ),
    );
  }
}