import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:criminal_catcher/core/services/location_service.dart';
import 'package:get_it/get_it.dart';

import 'features/fir_registration/domain/data_sources/fir_remote_data_source.dart';
import 'features/fir_registration/data/data_sources/fir_remote_data_source_impl.dart';


  final GetIt sl = GetIt.instance;

  void initInjection() {
    sl.registerLazySingleton<LocationService>(() => LocationService());
    sl.registerLazySingleton<FIRRemoteDataSource>(
          () => FIRRemoteDataSourceImpl(FirebaseFirestore.instance),
    );

  }
