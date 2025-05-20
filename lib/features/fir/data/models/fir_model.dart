import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/fir_entity.dart';

class FIRModel extends FIREntity {
  const FIRModel({super.complaintType,
      super.description,
      super.dateTime,
      super.location,
      super.evidencePaths,
      super.userId,
      super.userName,
      super.userEmail,
      super.userPhone,
      super.status,
      super.firId,
      });

  // Convert Entity → Model
  factory FIRModel.fromEntity(FIREntity entity) {
    return FIRModel(

      complaintType: entity.complaintType,
      description: entity.description,
      dateTime: entity.dateTime,
      location: entity.location,
      evidencePaths: entity.evidencePaths,
      userId: entity.userId,
      userName: entity.userName,
      userEmail: entity.userEmail,
      userPhone: entity.userPhone,
      status: entity.status,
      firId: entity.firId,
    );
  }

  // For saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'complaintType': complaintType,
      'description': description,
      'dateTime': dateTime==null? null:Timestamp.fromDate(dateTime!),
      'location': location,
      'evidencePaths': evidencePaths,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'status': status,
      'firId': firId,
    };
  }

  // For reading from Firestore
  factory FIRModel.fromMap(Map<String, dynamic> map) {
    return FIRModel(
      complaintType: map['complaintType'],
      description: map['description'],
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      location: map['location'],
      evidencePaths: map['evidencePaths'] != null
          ? List<String>.from(map['evidencePaths'])
          : null,
      userId: map['userId'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      userPhone: map['userPhone'],
      status: map['status'],
      firId: map['firId'],
    );
  }
}
