import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class SignInWithGoogleUsecase implements Usecase<Either, bool> {
  @override
  Future<Either<Failure,UserEntity>> call({bool? params}) {
    return sl<AuthRepository>().signInWithGoogle(params!);
  }
}