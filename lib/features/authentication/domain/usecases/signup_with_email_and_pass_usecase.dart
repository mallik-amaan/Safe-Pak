import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../entities/sign_in_params.dart';
import '../repository/auth_repository.dart';

class SignUpWithEmailAndPassUsecase implements Usecase<Either, SignInParams> {
  @override
  Future<Either> call({SignInParams? params}) {
    return sl<AuthRepository>().signUpWithEmailAndPassword(params!.email, params.password,params.name);
  }
}