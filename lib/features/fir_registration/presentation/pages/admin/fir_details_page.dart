import 'package:flutter/material.dart';
import 'package:safepak/features/fir_registration/presentation/widgets/action_button.dart';

class FirDetailsPage extends StatelessWidget {
  const FirDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "FIR Details",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text("Manage FIR details",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                // Add your FIR details here
                Text(
                  "FIR ID: 123456",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Description: This is a sample FIR description.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  "Location: Sample Location",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text("Evidence: Sample evidence details",
                    style: Theme.of(context).textTheme.bodyMedium),
                actionButton(context, "Change Status", () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
