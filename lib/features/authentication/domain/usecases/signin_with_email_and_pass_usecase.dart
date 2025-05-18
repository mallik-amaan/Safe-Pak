import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/sign_in_params.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class SignInWithEmailAndPassUsecase implements Usecase<Either, SignInParams> {
  @override
  Future<Either<Failure,UserEntity>> call({SignInParams? params}) {
    return sl<AuthRepository>().signInWithEmailAndPassword(params!.email, params.password);
  }
}