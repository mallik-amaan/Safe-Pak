import 'package:dartz/dartz.dart';
import 'package:safepak/features/fir_registration/domain/entities/fir_entity.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../../domain/repositories/fir_repository.dart';

class SubmitFirUsecase implements Usecase<Either, FIREntity> {
  @override
  Future<Either> call({FIREntity? params}) {
    return sl<FirRepository>().submitFIR(params!);
  }
}