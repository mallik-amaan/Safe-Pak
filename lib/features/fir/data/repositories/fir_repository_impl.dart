import 'package:dartz/dartz.dart';

import 'package:safepak/core/common/classes/failure.dart';

import 'package:safepak/core/common/classes/no_params.dart';

import 'package:safepak/features/fir/domain/entities/fir_entity.dart';

import '../../../../dependency_injection.dart';
import '../../domain/repositories/fir_repository.dart';
import '../data_sources/fir_remote_data_source.dart';

class FirRepositoryImpl extends FirRepository{
  @override
  Future<Either<Failure, NoParams>> submitFIR(FIREntity fir) => sl<FirRemoteDataSource>().submitFIR(fir);

  @override
  Future<Either<Failure, List<FIREntity>>> getFIRs() => sl<FirRemoteDataSource>().getFIRs();
  
  @override
  Future<Either<Failure, NoParams>> deleteFIR(FIREntity fir) => sl<FirRemoteDataSource>().deleteFIR(fir);

  @override
  Future<Either<Failure, NoParams>> updateFIR(FIREntity fir) => sl<FirRemoteDataSource>().updateFIR(fir);

}