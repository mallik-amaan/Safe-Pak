import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/features/fir_registration/data/models/fir_model.dart';

import '../../domain/data_sources/fir_remote_data_source.dart';
import '../../domain/entities/fir_entity.dart';
import '../../domain/repositories/fir_repository.dart';

class FIRRepositoryImpl implements FIRRepository {
  final FIRRemoteDataSource remoteDataSource;

  FIRRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, bool>> submitFIR(FIREntity fir) async {
    final firModel = FIRModel.fromEntity(fir);
    return await remoteDataSource.submitFIR(firModel);
  }
}