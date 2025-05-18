import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/common/classes/failure.dart';
import '../models/fir_model.dart';
import '../../domain/data_sources/fir_remote_data_source.dart';

class FIRRemoteDataSourceImpl implements FIRRemoteDataSource {
  final FirebaseFirestore firestore;

  FIRRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failure, bool>> submitFIR(FIRModel fir) async {
    try {
      await firestore.collection('firs').add(fir.toMap());
      return right(true);
    } catch (error) {
      return left(Failure(message: error.toString()));
    }
  }
}
