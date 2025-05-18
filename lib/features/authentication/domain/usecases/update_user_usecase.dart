import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class UpdateUserUsecase implements Usecase<Either<Failure,UserEntity>, UserEntity> {
  @override
  Future<Either<Failure,UserEntity>> call({UserEntity? params}) {
    return sl<AuthRepository>().updateUser(params!);
  }
}