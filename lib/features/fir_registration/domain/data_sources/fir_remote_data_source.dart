import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/features/fir_registration/data/models/fir_model.dart';

abstract class FIRRemoteDataSource {
 Future<Either<Failure, bool>> submitFIR(FIRModel fir);
}