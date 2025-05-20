import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../entities/criminal_alert_entity.dart';

abstract class CriminalAlertRepository {

  // Create a new criminal alert
  Future<Either<Failure, NoParams>> createAlert(CriminalAlertEntity params);

  // Fetch alerts created by the current user
  Future<Either<Failure, List<dynamic>>> fetchMyAlerts();

  // Fetch all criminal alerts
  Future<Either<Failure, List<dynamic>>> fetchAllAlerts();
}
