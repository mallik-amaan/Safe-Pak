
import 'package:dartz/dartz.dart';

import 'package:safepak/core/common/classes/failure.dart';

import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/emeregency_sos/data/data_sources/emergency_remote_data_source.dart';

import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';

import '../../domain/repositories/criminal_alert_repository.dart';

class CriminalAlertRepositoryImpl extends CriminalAlertRepository {
  @override
  Future<Either<Failure, NoParams>> addEmergencyContact(EmergencyContactEntity params) => sl<EmergencyRemoteDataSource>().addEmergencyContact(params);
  
  @override
  Future<Either<Failure, List<EmergencyContactEntity>>> getEmergencyContact() => sl<EmergencyRemoteDataSource>().getEmergencyContact();
  
  @override
  Future<Either<Failure, NoParams>> deleteContact(EmergencyContactEntity contact) => sl<EmergencyRemoteDataSource>().deleteContact(contact);


}