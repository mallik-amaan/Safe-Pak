import 'package:flutter/material.dart';

class AlertActionButton extends StatefulWidget {
  final String label;
  final Function onPressed;
  final Color color;
  final Color textColor;
  const AlertActionButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  State<AlertActionButton> createState() => _AlertActionButtonState();
}

class _AlertActionButtonState extends State<AlertActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call onPressed directly instead of opening a new dialog
        widget.onPressed();
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

void takeActionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Take Action"),
        content: const Text(
            "Do you want to dispatch police to the emergency location?"),
        actions: [
          AlertActionButton(
            label: "Dispatch Police",
            onPressed: () {
              // Close the current dialog
              Navigator.of(context).pop();
              // Perform the dispatch action
              print("Police dispatched!");
              // Optional: Show a confirmation dialog
              showConfirmationDialog(context);
            },
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ],
      );
    },
  );
}

// Optional: Show a confirmation dialog after dispatching police
void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Success"),
        content: const Text("Police have been dispatched to the location."),
        actions: [
          AlertActionButton(
            label: "OK",
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
          ),
        ],
      );
    },
  );
}
