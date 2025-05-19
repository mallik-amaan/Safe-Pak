import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/fir_entity.dart';

class FIRModel extends FIREntity {
  const FIRModel({super.complaintType,
      super.description,
      super.dateTime,
      super.location,
      super.evidencePaths});

  // Convert Entity → Model
  factory FIRModel.fromEntity(FIREntity entity) {
    return FIRModel(
      complaintType: entity.complaintType,
      description: entity.description,
      dateTime: entity.dateTime,
      location: entity.location,
      evidencePaths: entity.evidencePaths,
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
    );
  }
}
