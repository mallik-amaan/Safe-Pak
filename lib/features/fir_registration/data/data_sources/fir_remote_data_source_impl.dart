import '../models/fir_model.dart';
import '../../domain/data_sources/fir_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FIRRemoteDataSourceImpl implements FIRRemoteDataSource {
  final FirebaseFirestore firestore;

  FIRRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> submitFIR(FIRModel fir) async {
    await firestore.collection('firs').add(fir.toMap());
  }
}
