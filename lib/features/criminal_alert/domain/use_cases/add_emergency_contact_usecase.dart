import 'package:dartz/dartz.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/criminal_alert_repository.dart';

class AddEmergencyContactUseCase implements Usecase<Either, EmergencyContactEntity> {
  @override
  Future<Either> call({EmergencyContactEntity? params}) {
    return sl<CriminalAlertRepository>().addEmergencyContact(params!);
  }
}