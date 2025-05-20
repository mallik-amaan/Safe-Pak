import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';

class EmergencyModel extends EmergencyEntity {
  const EmergencyModel({
    super.name,
    super.phoneNumber,
    super.location,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    return EmergencyModel(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'location': location,
    };
  }

  factory EmergencyModel.fromEntity(EmergencyEntity emergency) {
    return EmergencyModel(
        name: emergency.name,
        phoneNumber: emergency.phoneNumber,
        location: emergency.location);
  }
}
