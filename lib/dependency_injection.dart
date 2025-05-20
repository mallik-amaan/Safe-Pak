import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:safepak/features/criminal_alert/data/data_sources/criminal_alert_remote_data_source.dart';
import 'package:safepak/features/criminal_alert/data/data_sources/criminal_alert_remote_data_source_impl.dart';
import 'package:safepak/features/criminal_alert/data/repositories/criminal_alert_repository_impl.dart';
import 'package:safepak/features/criminal_alert/domain/repositories/criminal_alert_repository.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/add_alert_usecase.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/fetch_all_alerts_usecase.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/fetch_my_alerts_usecase.dart';
import 'package:safepak/features/criminal_alert/presentation/cubit/alert_cubit.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/add_emergency_contact_usecase.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/delete_contact_usecase.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/get_emergency.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/get_emergency_contact_usecase.dart';
import 'package:safepak/features/emeregency_sos/domain/use_cases/send_emergency.dart';
import 'package:safepak/features/fir/domain/use_cases/delete_fir_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/get_firs_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/get_my_fir_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/submit_fir_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/update_fir_usecase.dart';

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
import 'features/emeregency_sos/data/data_sources/emergency_remote_data_source.dart';
import 'features/emeregency_sos/data/data_sources/emergency_remote_data_source_impl.dart';
import 'features/emeregency_sos/data/repositories/emergency_repository_impl.dart';
import 'features/emeregency_sos/domain/repositories/emergency_repository.dart';
import 'features/emeregency_sos/presentation/cubit/emergency_cubit.dart';
import 'features/fir/data/data_sources/fir_remote_data_source.dart';
import 'features/fir/data/data_sources/fir_remote_data_source_impl.dart';
import 'features/fir/data/repositories/fir_repository_impl.dart';
import 'features/fir/domain/repositories/fir_repository.dart';
import 'features/fir/presentation/cubit/fir_cubit.dart';

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

  sl.registerLazySingleton(() => SubmitFirUsecase());
  sl.registerLazySingleton(() => GetFirsUsecase());
  sl.registerLazySingleton(() => DeleteFirUsecase());
  sl.registerLazySingleton(() => UpdateFirUsecase());
  sl.registerLazySingleton(() => GetMyFirsUsecase());
  
  sl.registerFactory<FirCubit>(() => FirCubit(
    getFIRsUseCase: sl(),
    deleteFIRUseCase: sl(),
    updateFIRUseCase: sl(),
    getMyFIRsUseCase: sl(),
    submitFIRUseCase: sl()));

  sl.registerLazySingleton<FirRemoteDataSource>(
    () => FirRemoteDataSourceImpl(firebaseFireStore: sl()),
  );
  sl.registerLazySingleton<FirRepository>(() => FirRepositoryImpl());


  sl.registerLazySingleton(() => AddEmergencyContactUseCase());
  sl.registerLazySingleton(() => GetEmergencyContactUseCase());

  sl.registerLazySingleton(() =>  SendEmergencyUseCase());
  sl.registerLazySingleton(() =>  GetEmergencyUseCase());

  sl.registerLazySingleton(() => DeleteContactUseCase());
  sl.registerFactory<EmergencyCubit>(() => EmergencyCubit(addEmergencyContactUseCase: sl(),getEmergencyContactsUseCase: sl(),deleteEmergencyContactUseCase: sl()));

  sl.registerLazySingleton<EmergencyRemoteDataSource>(
    () => EmergencyRemoteDataSourceImpl(firebaseFireStore: sl()),
  );
  sl.registerLazySingleton<EmergencyRepository>(() => EmergencyRepositoryImpl());


  sl.registerLazySingleton(() => AddAlertUsecase());
  sl.registerLazySingleton(() => FetchMyAlertsUsecase());
  sl.registerLazySingleton(() => FetchAllAlertsUsecase());
  sl.registerFactory<AlertCubit>(() => AlertCubit(
    createAlertUseCase: sl(),
    fetchMyAlertsUsecase: sl(),
    fetchAllAlertsUseCase: sl(),
  ));

  sl.registerLazySingleton<CriminalAlertRemoteDataSource>(
    () => CriminalAlertRemoteDataSourceImpl(firebaseFireStore: sl()),
  );
  sl.registerLazySingleton<CriminalAlertRepository>(() => CriminalAlertRepositoryImpl());


  
}
