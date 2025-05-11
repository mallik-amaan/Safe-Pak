import 'package:criminal_catcher/FIR%20Registration/widgets/fir_text_field.dart';
import 'package:flutter/material.dart';

class FirRegistration extends StatefulWidget {
  const FirRegistration({super.key});

  @override
  _FirRegistrationState createState() => _FirRegistrationState();
}

class _FirRegistrationState extends State<FirRegistration> {
  String? _selectedType;

  final List<DropdownMenuItem<String>> _complaintTypes = const [
    DropdownMenuItem(value: "theft", child: Text("Theft")),
    DropdownMenuItem(value: "assault", child: Text("Assault")),
    DropdownMenuItem(value: "fault", child: Text("Fault")),
    DropdownMenuItem(value: "robbery", child: Text("Robbery")),
    DropdownMenuItem(value: "other", child: Text("Other")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FIR Registration"),
        backgroundColor: Theme.of(context).highlightColor, // Colors.black
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              hint: Text(
                "Choose complaint type",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              items: _complaintTypes,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Type of Complaint",
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, // Colors.black
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).highlightColor, // Colors.white
              ),
              style: Theme.of(context).textTheme.bodyLarge, // Font size 16
              dropdownColor: Theme.of(context).highlightColor, // Colors.white
              icon: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).primaryColor, // Colors.black
              ),
            ),
            FIRTextField(context, "Incident Description", Icons.abc_outlined, )

            
          ],
        ),
      ),
    );
  }
}
