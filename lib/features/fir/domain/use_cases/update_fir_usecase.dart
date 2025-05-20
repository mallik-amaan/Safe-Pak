import 'package:dartz/dartz.dart';
import 'package:safepak/features/fir/domain/entities/fir_entity.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/fir_repository.dart';

class UpdateFirUsecase implements Usecase<Either, FIREntity> {
  @override
  Future<Either> call({FIREntity? params}) {
    return sl<FirRepository>().updateFIR(params!);
  }
}