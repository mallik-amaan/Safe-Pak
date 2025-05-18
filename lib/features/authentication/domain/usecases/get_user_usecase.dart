import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class GetUserUsecase implements Usecase<Either, NoParams> {
  @override
  Future<Either<Failure,UserEntity>> call({NoParams? params}) {
    return sl<AuthRepository>().getUser();
  }
}