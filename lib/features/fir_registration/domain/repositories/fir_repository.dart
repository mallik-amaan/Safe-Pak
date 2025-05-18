import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart';
import '../entities/fir_entity.dart';

abstract class FIRRepository {
  Future<Either<Failure,bool>> submitFIR(FIREntity fir);
}
