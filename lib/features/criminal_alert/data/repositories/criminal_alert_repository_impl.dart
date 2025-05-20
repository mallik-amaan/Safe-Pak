
import 'package:dartz/dartz.dart';

import 'package:safepak/core/common/classes/failure.dart';

import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/features/criminal_alert/data/data_sources/criminal_alert_remote_data_source.dart';
import 'package:safepak/features/criminal_alert/domain/entities/criminal_alert_entity.dart';

import '../../../../dependency_injection.dart';
import '../../domain/repositories/criminal_alert_repository.dart';

class CriminalAlertRepositoryImpl extends CriminalAlertRepository {
  @override
  Future<Either<Failure, NoParams>> createAlert(CriminalAlertEntity params) => sl<CriminalAlertRemoteDataSource>().createAlert(params);

  @override
  Future<Either<Failure, List>> fetchAllAlerts() => sl<CriminalAlertRemoteDataSource>().fetchAllAlerts();

  @override
  Future<Either<Failure, List>> fetchMyAlerts() => sl<CriminalAlertRemoteDataSource>().fetchMyAlerts();


}