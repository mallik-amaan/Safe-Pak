import 'package:dartz/dartz.dart';
import 'package:safepak/features/criminal_alert/domain/entities/criminal_alert_entity.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/criminal_alert_repository.dart';

class AddAlertUsecase implements Usecase<Either, CriminalAlertEntity> {
  @override
  Future<Either> call({CriminalAlertEntity? params}) {
    return sl<CriminalAlertRepository>().createAlert(params!);
  }
}