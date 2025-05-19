import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';

class EmergencyContactModel extends EmergencyContactEntity{
  const EmergencyContactModel({
    super.name,
    super.phoneNumber,
    super.relation,
    super.isPrimary
  });

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    return EmergencyContactModel(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      relation: json['relation'] ?? '',
      isPrimary: json['isPrimary'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'relation': relation,
      'isPrimary': isPrimary,
    };
  }

  factory EmergencyContactModel.fromEntity(EmergencyContactEntity contact){
    return EmergencyContactModel(
      name: contact.name,
      phoneNumber: contact.phoneNumber,
      relation: contact.relation,
      isPrimary: contact.isPrimary
    );
  }
}