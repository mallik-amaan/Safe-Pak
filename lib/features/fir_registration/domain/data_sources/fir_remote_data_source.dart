
import 'package:criminal_catcher/features/fir_registration/data/models/fir_model.dart';
import 'package:criminal_catcher/features/fir_registration/domain/entities/fir_entity.dart';

 abstract class FIRRemoteDataSource{
  Future<void> submitFIR(FIRModel fir) async {}

}