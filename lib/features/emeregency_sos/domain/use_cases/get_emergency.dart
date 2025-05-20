import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/emergency_repository.dart';

class GetEmergencyUseCase
    implements Usecase<Either<Failure, List<EmergencyEntity>>, NoParams> {
  @override
  Future<Either<Failure, List<EmergencyEntity>>> call({NoParams? params}) {
    return sl<EmergencyRepository>().getEmergency();
  }
}
