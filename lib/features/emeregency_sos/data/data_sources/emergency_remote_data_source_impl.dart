import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/core/services/user_singleton.dart';
import 'package:safepak/features/emeregency_sos/data/models/emergency_contact_model.dart';
import 'package:safepak/features/emeregency_sos/data/models/emergency_model.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_entity.dart';
import 'emergency_remote_data_source.dart';

class EmergencyRemoteDataSourceImpl extends EmergencyRemoteDataSource {
  final FirebaseFirestore firebaseFireStore;

  EmergencyRemoteDataSourceImpl({required this.firebaseFireStore});


  @override
  Future<Either<Failure, NoParams>> addEmergencyContact(EmergencyContactEntity contact) async{
    try {
      final user = UserSingleton().user;
      Map<String, dynamic> data = EmergencyContactModel.fromEntity(contact).toJson();
      final docRef = await firebaseFireStore
          .collection('users')
          .doc(user!.uid)
          .collection('emergencyContacts')
          .add(data);
      // Update the document with its own id
      await docRef.update({'id': docRef.id});
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
      
  }
  
  @override
  Future<Either<Failure, List<EmergencyContactEntity>>> getEmergencyContact() async{
    try {
      final user = UserSingleton().user;
      final docList = await firebaseFireStore
          .collection('users')
          .doc(user!.uid)
          .collection('emergencyContacts')
          .get();
        List<EmergencyContactEntity> contacts = [];
        for (var element in docList.docs) {
          contacts.add(EmergencyContactModel.fromJson(element.data()));
        }
        return Right(contacts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, NoParams>> deleteContact(EmergencyContactEntity contact) async{
    try {
      final user = UserSingleton().user;
      final query = await firebaseFireStore
        .collection('users')
        .doc(user!.uid)
        .collection('emergencyContacts')
        .where('id',isEqualTo: contact.id)
        .get();

      if (query.docs.isEmpty) {
      return Left(Failure(message: 'Contact not found'));
      }

      for (var doc in query.docs) {
      await doc.reference.delete();
      }

      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }



  @override
  Future<Either<Failure, NoParams>> sendEmergency(EmergencyEntity emergency) async {
     try {
      Map<String, dynamic> data = EmergencyModel.fromEntity(emergency).toJson();
      final docRef = await firebaseFireStore
          .collection('emergency')
          .add(data);
      // Update the document with its own id
      await docRef.update({'id': docRef.id});
      return Right(NoParams());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<EmergencyEntity>>> getEmergency() async{
    try {
      final docList = await firebaseFireStore
          .collection('emergency')
          .get();
        List<EmergencyEntity> emergency = [];
        for (var element in docList.docs) {
          emergency.add(EmergencyModel.fromJson(element.data()));
        }
        return Right(emergency);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
