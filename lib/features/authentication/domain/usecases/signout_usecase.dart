import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';
class SignOutUsecase implements Usecase<Either, UserEntity> {
  @override
  Future<Either> call({UserEntity? params}) {
    return sl<AuthRepository>().signOut();
  }
}