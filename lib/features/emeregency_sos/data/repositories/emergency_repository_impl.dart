
import 'package:dartz/dartz.dart';

import 'package:safepak/core/common/classes/failure.dart';

import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/emeregency_sos/data/data_sources/emergency_remote_data_source.dart';

import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';

import '../../domain/repositories/emergency_repository.dart';

class EmergencyRepositoryImpl extends EmergencyRepository{
  @override
  Future<Either<Failure, NoParams>> addEmergencyContact(EmergencyContactEntity params) => sl<EmergencyRemoteDataSource>().addEmergencyContact(params);
  
  @override
  Future<Either<Failure, List<EmergencyContactEntity>>> getEmergencyContact() => sl<EmergencyRemoteDataSource>().getEmergencyContact();
  
  @override
  Future<Either<Failure, NoParams>> deleteContact(EmergencyContactEntity contact) => sl<EmergencyRemoteDataSource>().deleteContact(contact);

  @override
  Future<Either<Failure, List<EmergencyEntity>>> getEmergency() => sl<EmergencyRemoteDataSource>().getEmergency();

  @override
  Future<Either<Failure, NoParams>> sendEmergency(EmergencyEntity emergency) => sl<EmergencyRemoteDataSource>().sendEmergency(emergency);


}