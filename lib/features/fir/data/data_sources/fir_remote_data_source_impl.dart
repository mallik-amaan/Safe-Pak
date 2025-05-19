import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/core/services/upload_service.dart';
import 'package:safepak/core/services/user_singleton.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';
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
      UserEntity user = UserSingleton().user!;
      Map<String, dynamic> data = FIRModel.fromEntity(fir).toMap();
      data['evidencePaths'] = images;
      data.addAll({
        'user_id': user.uid,
        'user_name': user.name,
        'user_email': user.email,
        'user_phone': user.phoneNumber,
      });
      await firebaseFireStore.collection('fir_reports').add(data);
      return const Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
