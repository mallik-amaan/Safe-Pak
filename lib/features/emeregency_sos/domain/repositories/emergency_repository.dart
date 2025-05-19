import 'package:dartz/dartz.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';

abstract class EmergencyRepository {
  Future<Either<Failure,NoParams>> addEmergencyContact(EmergencyContactEntity params);

  Future<Either<Failure,List<EmergencyContactEntity>>> getEmergencyContact();
}
