import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import '../entities/fir_entity.dart';
import '../repositories/fir_repository.dart';

class SubmitFIRUseCase {
  final FIRRepository repository;

  SubmitFIRUseCase(this.repository);

  Future<Either<Failure, bool>> call(FIREntity fir) async {
    return await repository.submitFIR(fir);
  }
}