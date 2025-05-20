import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class FIRTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final int minLines;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffix;


  const FIRTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.minLines = 1,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.suffix, required bool enabled,
  }) : super(key: key);

  @override
  _FIRTextFieldState createState() => _FIRTextFieldState();
}

class _FIRTextFieldState extends State<FIRTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showDateDialog(BuildContext context) async {
    if (widget.label == "Date and Time") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select Date and Time"),
            content: DateTimePicker(
              type: DateTimePickerType.dateTime,
              initialValue: '',
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _controller.text = value;
                  });
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        TextField(
          onTap: widget.onTap ?? () => _showDateDialog(context),
          minLines: widget.minLines,
          maxLines: 10,
          controller: _controller,
          readOnly: widget.readOnly || widget.label == "Date and Time",
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Theme.of(context).primaryColor),
            suffixIcon: widget.suffix,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
        ),

      ],
    );
  }
}
