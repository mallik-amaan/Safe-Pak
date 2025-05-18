import 'dart:ffi';

import '../entities/fir_entity.dart';
import '../repositories/fir_repository.dart';
import 'package:dartz/dartz.dart';
class SubmitFIRUseCase {
  final FIRRepository repository;

  SubmitFIRUseCase(this.repository);

  Future<Either<Failure,Void>> call(FIREntity fir) async {
    return left();
  }
}

class Failure {
}
