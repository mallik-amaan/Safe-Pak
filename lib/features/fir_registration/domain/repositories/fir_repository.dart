import '../entities/fir_entity.dart';

abstract class FIRRepository {
  Future<void> submitFIR(FIREntity fir);
}
