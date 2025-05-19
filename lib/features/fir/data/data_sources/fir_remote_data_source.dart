import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../../domain/entities/fir_entity.dart';

abstract class FirRemoteDataSource {
  Future<Either<Failure,NoParams>> submitFIR(FIREntity fir);
}
