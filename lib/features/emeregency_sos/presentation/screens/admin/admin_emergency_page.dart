import 'package:flutter/material.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/get_emergency.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/get_emergency_contact_usecase.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/admin/alert_card.dart';

class AdminEmergencyPage extends StatefulWidget {
  const AdminEmergencyPage({super.key});

  @override
  _AdminEmergencyPageState createState() => _AdminEmergencyPageState();
}

class _AdminEmergencyPageState extends State<AdminEmergencyPage> {
  bool isLoading = false;
  late List<EmergencyEntity> emergencyList;
  @override
  void initState() {
    super.initState();
    // your initialization logic here
    getEmergencyContacts();
  }

  void getEmergencyContacts() async {
    setState(() {
      isLoading = true;
    });
    var result = await sl<GetEmergencyUseCase>().call();
    emergencyList = result.fold(
      (failure) {
        // Handle failure

        return [];
      },
      (emergencyList) {
        // Handle success
        return emergencyList;
      },
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : emergencyList.isEmpty
                ? const Center(
                    child: Text("No emergency calls available"),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Emergency Alerts",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text("Nearby emergency calls",
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: emergencyList.length,
                            itemBuilder: (context, index) {
                              return AlertCard(
                                label: emergencyList[index].name!,
                                description: emergencyList[index].phoneNumber!,
                                location: emergencyList[index].location!,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ));
  }
}
