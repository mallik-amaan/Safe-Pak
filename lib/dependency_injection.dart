import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/services/location_service.dart';
import 'features/authentication/data/repository/auth_repository_impl.dart';
import 'features/authentication/data/source/auth_remote_data_source.dart';
import 'features/authentication/data/source/auth_remote_data_source_impl.dart';
import 'features/authentication/domain/repository/auth_repository.dart';
import 'features/authentication/domain/usecases/delete_account_usecase.dart';
import 'features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'features/authentication/domain/usecases/get_user_usecase.dart';
import 'features/authentication/domain/usecases/signin_with_email_and_pass_usecase.dart';
import 'features/authentication/domain/usecases/signin_with_google_usecase.dart';
import 'features/authentication/domain/usecases/signup_with_email_and_pass_usecase.dart';
import 'features/authentication/domain/usecases/update_user_usecase.dart';
import 'features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';
import 'features/fir_registration/data/data_sources/fir_remote_data_source_impl.dart';
import 'features/fir_registration/data/repositories/fir_repository_impl.dart';
import 'features/fir_registration/domain/data_sources/fir_remote_data_source.dart';
import 'features/fir_registration/domain/repositories/fir_repository.dart';
import 'features/fir_registration/domain/use_cases/submit_fir_usecase.dart';
import 'features/fir_registration/presentation/bloc/fir_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Core services
  sl.registerLazySingleton<LocationService>(() => LocationService());

  // Auth domain layer
  sl.registerLazySingleton(() => SignInWithGoogleUsecase());
  sl.registerLazySingleton(() => SignInWithEmailAndPassUsecase());
  sl.registerLazySingleton(() => SignUpWithEmailAndPassUsecase());
  sl.registerLazySingleton(() => UpdateUserUsecase());
  sl.registerLazySingleton(() => GetUserUsecase());
  sl.registerLazySingleton(() => ForgotPasswordUsecase());
  sl.registerLazySingleton(() => DeleteAccountUsecase());

  // Auth data layer
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      firebaseFirestore: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Auth BLoC
  sl.registerFactory(() => AuthenticationCubit(
    forgotPasswordUsecase: sl(),
    updateUserUsecase: sl(),
    signInWithEmailAndPassUsecase: sl(),
    signInWithGoogleUsecase: sl(),
    signUpWithEmailAndPassUsecase: sl(),
    getUserUsecase: sl(),
    deleteAccountUsecase: sl(),
  ));

  // FIR DataLayer
  sl.registerLazySingleton<FIRRemoteDataSource>(
          () => FIRRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<FIRRepository>(() => FIRRepositoryImpl(sl()));

  //FIR Domain Layer
  sl.registerLazySingleton(() => SubmitFIRUseCase(sl()));

  //FIR Bloc
  sl.registerFactory(() => FIRBloc(submitFIRUseCase: sl()));
}
