import 'package:equatable/equatable.dart';

class FIREntity extends Equatable{
  final String? complaintType;
  final String? description;
  final DateTime? dateTime;
  final String? location;
  final List<String>? evidencePaths;

  const FIREntity({
    this.complaintType,
    this.description,
    this.dateTime,
    this.location,
    this.evidencePaths,
  });
  
  @override
  List<Object?> get props => [
    complaintType,
    description,
    dateTime,
    location,
    evidencePaths
  ];

  
}
