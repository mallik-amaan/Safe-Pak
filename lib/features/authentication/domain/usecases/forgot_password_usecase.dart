import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart';
import '../../../../core/common/classes/usecase.dart';
import '../../../../dependency_injection.dart' show sl;
import '../repository/auth_repository.dart';

class ForgotPasswordUsecase implements Usecase<Either, String> {
  @override
  Future<Either<Failure,NoParams>> call({String? params}) {
    return sl<AuthRepository>().forgotPassword(params!);
  }
}