import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../entities/fir_entity.dart';

abstract class FirRepository {
  Future<Either<Failure,NoParams>> submitFIR(FIREntity fir);
  Future<Either<Failure,List<FIREntity>>> getFIRs();
  Future<Either<Failure,NoParams>> deleteFIR(FIREntity fir);
  Future<Either<Failure,NoParams>> updateFIR(FIREntity fir);
}
