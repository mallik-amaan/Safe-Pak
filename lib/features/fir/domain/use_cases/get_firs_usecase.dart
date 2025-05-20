import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repositories/fir_repository.dart';

class GetFirsUsecase implements Usecase<Either, NoParams> {
  @override
  Future<Either> call({NoParams? params}) {
    return sl<FirRepository>().getFIRs();
  }
}