import 'package:dartz/dartz.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/emergency_repository.dart';

class SendEmergencyUseCase implements Usecase<Either, EmergencyEntity> {
  @override
  Future<Either> call({EmergencyEntity? params}) {
    return sl<EmergencyRepository>().sendEmergency(params!);
  }
}
