import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/no_params.dart' show NoParams;
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;

class DeleteAccountUsecase implements Usecase<Either<Failure,NoParams>, UserEntity> {
  @override
  Future<Either<Failure,NoParams>> call({UserEntity? params}) {
    return sl<AuthRepository>().deleteAccount();
  }
}