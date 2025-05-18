import 'package:criminal_catcher/features/fir_registration/data/models/fir_model.dart';

import '../../domain/entities/fir_entity.dart';
import '../../domain/repositories/fir_repository.dart';
import '../../domain/data_sources/fir_remote_data_source.dart';


class FIRRepositoryImpl implements FIRRepository {
  final FIRRemoteDataSource remoteDataSource;

  FIRRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitFIR(FIREntity fir) async {
    final firModel = FIRModel.fromEntity(fir);
    await remoteDataSource.submitFIR(firModel);
  }

}
