import 'package:safepak/features/criminal_alert/domain/entities/criminal_alert_entity.dart';

class CriminalAlertModel extends CriminalAlertEntity {
  const CriminalAlertModel({
    required super.id,
    required super.title,
    required super.description,
    required super.images,
    required super.city,
    required super.createdAt,
  });

  factory CriminalAlertModel.fromEntity(CriminalAlertEntity entity) {
    return CriminalAlertModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      images: List<String>.from(entity.images),
      city: entity.city,
      createdAt: entity.createdAt,
    );
  }

  factory CriminalAlertModel.fromJson(Map<String, dynamic> json) {
    return CriminalAlertModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      images: List<String>.from(json['images'] as List),
      city: json['city'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'city': city,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}