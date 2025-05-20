import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/core/services/upload_service.dart';
import 'package:safepak/features/fir/data/models/fir_model.dart';
import 'package:safepak/features/fir/domain/entities/fir_entity.dart';
import 'fir_remote_data_source.dart';

class FirRemoteDataSourceImpl extends FirRemoteDataSource {
  final FirebaseFirestore firebaseFireStore;

  FirRemoteDataSourceImpl({required this.firebaseFireStore});

  @override
  Future<Either<Failure, NoParams>> submitFIR(FIREntity fir) async {
    try {
      List<String> images = [];
      for (var filePath in fir.evidencePaths!){
        File file = File(filePath);
        String imageUrl = await uploadFile(file);
        images.add(imageUrl);
      }
      Map<String, dynamic> data = FIRModel.fromEntity(fir).toMap();
      data['evidencePaths'] = images;
      final doc = await firebaseFireStore.collection('fir_reports').add(data);
      // Update the document with its own id
      await doc.update({'firId': doc.id});
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FIREntity>>> getFIRs() async {
    try {
      final docList = await firebaseFireStore.collection('fir_reports').get();
      List<FIREntity> firs = [];
      for (var element in docList.docs) {
        firs.add(FIRModel.fromMap(element.data()));
      }
      return Right(firs);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoParams>> deleteFIR(FIREntity fir) async {
    try {
      final query = await firebaseFireStore
          .collection('fir_reports')
          .where('firId', isEqualTo: fir.firId)
          .get();
      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.delete();
      }
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NoParams>> updateFIR(FIREntity fir) async {
    try {
      final query = await firebaseFireStore
          .collection('fir_reports')
          .where('firId', isEqualTo: fir.firId)
          .get();
      if (query.docs.isNotEmpty) {
        await query.docs.first.reference.update(FIRModel.fromEntity(fir).toMap());
      }
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
