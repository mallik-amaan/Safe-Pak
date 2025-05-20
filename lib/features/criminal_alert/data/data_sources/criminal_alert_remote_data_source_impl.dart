import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/core/services/user_singleton.dart';
import 'package:safepak/features/criminal_alert/data/models/criminal_alert_model.dart';
import 'package:safepak/features/criminal_alert/domain/entities/criminal_alert_entity.dart';
import '../../../../core/services/upload_service.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import 'criminal_alert_remote_data_source.dart';

class CriminalAlertRemoteDataSourceImpl extends CriminalAlertRemoteDataSource {
  final FirebaseFirestore firebaseFireStore;

  CriminalAlertRemoteDataSourceImpl({required this.firebaseFireStore});

  @override
  Future<Either<Failure, NoParams>> createAlert(
      CriminalAlertEntity params) async {
    try {
      List<String> images = [];
      for (var filePath in params.images) {
        File file = File(filePath);
        String imageUrl = await uploadFile(file);
        images.add(imageUrl);
      }
      Map<String, dynamic> data = CriminalAlertModel.fromEntity(params).toJson();
      data['images'] = images;
      final doc =
          await firebaseFireStore.collection('criminal_alerts').add(data);
      final docId = doc.id;
      await firebaseFireStore.collection('criminal_alerts').doc(docId).update({
        'id': docId,
      });
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List>> fetchAllAlerts() async {
    try {
      final snapshot =
          await firebaseFireStore.collection('criminal_alerts').get();
      final alerts = snapshot.docs.map((doc) {
        return CriminalAlertModel.fromJson(doc.data());
      }).toList();
      return Right(alerts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List>> fetchMyAlerts() async {
    try {
      UserEntity user = UserSingleton().user!;

      String userCity = user.city!;
      final snapshot = await firebaseFireStore
          .collection('criminal_alerts')
          .where('city', isEqualTo: userCity)
          .get();

      final alerts = snapshot.docs.map((doc) {
        return CriminalAlertModel.fromJson(doc.data());
      }).toList();

      return Right(alerts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
