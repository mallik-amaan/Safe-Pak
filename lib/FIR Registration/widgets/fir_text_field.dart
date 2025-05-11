import 'package:flutter/material.dart';

Widget FIRTextField(
  BuildContext context,
  String label,
  IconData icon,
) {
  TextEditingController controller = TextEditingController();
  return TextField(
    minLines: 5,
    maxLines: 10,
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
            BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
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
  );
}
