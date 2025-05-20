import 'package:equatable/equatable.dart';

class CriminalAlertEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final String city;
  final DateTime createdAt;

  const CriminalAlertEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.city,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        images,
        city,
        createdAt,
      ];
}
