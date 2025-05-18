import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// import '../../../../../core/configs/storage/local_storage.dart';
import '../../../../../core/common/classes/failure.dart' show Failure;
import '../../../domain/entities/sign_in_params.dart' show SignInParams;
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/delete_account_usecase.dart';
import '../../../domain/usecases/forgot_password_usecase.dart';
import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/signin_with_email_and_pass_usecase.dart';
import '../../../domain/usecases/signin_with_google_usecase.dart';
import '../../../domain/usecases/signup_with_email_and_pass_usecase.dart';
import '../../../domain/usecases/update_user_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final SignInWithEmailAndPassUsecase signInWithEmailAndPassUsecase;
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final SignUpWithEmailAndPassUsecase signUpWithEmailAndPassUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final GetUserUsecase getUserUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;

  AuthenticationCubit(
      {required this.deleteAccountUsecase,
      required this.signUpWithEmailAndPassUsecase,
      required this.updateUserUsecase,
      required this.signInWithEmailAndPassUsecase,
      required this.getUserUsecase,
      required this.forgotPasswordUsecase,
      required this.signInWithGoogleUsecase})
      : super(AuthenticationInitial());

  Future<void> signInWithGoogle({bool? isSignUp = false}) async {
    emit(AuthenticationLoading());
    final result = await signInWithGoogleUsecase.call(params: isSignUp);
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(Authenticated(user: r));
      },
    );
  }

  Future<void> signInWithEmailAndPassword(
      {required SignInParams params}) async {
    emit(AuthenticationLoading());
    final result = await signInWithEmailAndPassUsecase.call(params: params);
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(Authenticated(user: r));
      },
    );
  }

  Future<void> signUpWithEmailAndPassword(
      {required SignInParams params}) async {
    emit(AuthenticationLoading());
    final result = await signUpWithEmailAndPassUsecase.call(params: params);
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(AuthenticatedButNotComplete(user: r));
      },
    );
  }

  Future<void> updateUser({required UserEntity user}) async {
    emit(AuthenticationLoading());
    final result = await updateUserUsecase.call(params: user);
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(UserUpdated(r));
      },
    );
  }

  Future<void> getUser() async {
    emit(AuthenticationLoading());
    final result = await getUserUsecase.call();
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(Authenticated(user: r));
      },
    );
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthenticationLoading());
    final result = await forgotPasswordUsecase.call(params: email);
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(ForgotPasswordSuccess());
      },
    );
  }

  Future<void> deleteAccount() async {
    emit(AuthenticationLoading());
    final result = await deleteAccountUsecase.call();
    result.fold(
      (l) => emit(AuthenticationError(l)),
      (r) async {
        emit(AccountDeleted());
      },
    );
  }
}
