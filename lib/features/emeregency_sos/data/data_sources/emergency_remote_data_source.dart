import 'package:dartz/dartz.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';

abstract class EmergencyRemoteDataSource {
  Future<Either<Failure, NoParams>> addEmergencyContact(EmergencyContactEntity contact);

  Future<Either<Failure, List<EmergencyContactEntity>>> getEmergencyContact();

  Future<Either<Failure,NoParams>> deleteContact(EmergencyContactEntity contact);

  Future<Either<Failure, NoParams>> sendEmergency(EmergencyEntity emergency);

  Future<Either<Failure, List<EmergencyEntity>>> getEmergency();

}
