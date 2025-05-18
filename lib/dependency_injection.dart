import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safepak/features/authentication/domain/usecases/delete_account_usecase.dart';
import 'package:safepak/features/authentication/domain/usecases/get_user_usecase.dart' show GetUserUsecase;

import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/data/source/auth_remote_data_source.dart';
import 'features/authentication/data/source/auth_remote_data_source_impl.dart';
import 'features/authentication/domain/repository/auth_repository.dart';
import 'features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'features/authentication/domain/usecases/signin_with_email_and_pass_usecase.dart';
import 'features/authentication/domain/usecases/signin_with_google_usecase.dart';
import 'features/authentication/domain/usecases/signup_with_email_and_pass_usecase.dart' show SignUpWithEmailAndPassUsecase;
import 'features/authentication/domain/usecases/update_user_usecase.dart';
import 'features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton(() => SignInWithGoogleUsecase());
  sl.registerLazySingleton(() => SignInWithEmailAndPassUsecase());
  sl.registerLazySingleton(() => SignUpWithEmailAndPassUsecase());
  sl.registerLazySingleton(() => UpdateUserUsecase());
  sl.registerLazySingleton(() => GetUserUsecase());
  sl.registerLazySingleton(() => ForgotPasswordUsecase());
  sl.registerLazySingleton(() => DeleteAccountUsecase());

  sl.registerFactory(
    () => AuthenticationCubit(
      forgotPasswordUsecase: sl.call(),
      updateUserUsecase: sl.call(),
      signInWithEmailAndPassUsecase: sl.call(),
      signInWithGoogleUsecase: sl.call(),
      signUpWithEmailAndPassUsecase: sl.call(),
      getUserUsecase: sl.call(), deleteAccountUsecase: sl.call(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            firebaseAuth: sl.call(),
            firebaseFirestore: sl.call(),
      ));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
}