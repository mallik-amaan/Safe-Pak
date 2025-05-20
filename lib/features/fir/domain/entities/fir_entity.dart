import 'package:equatable/equatable.dart';

class FIREntity extends Equatable {
  final String? complaintType;
  final String? description;
  final DateTime? dateTime;
  final String? location;
  final List<String>? evidencePaths;
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? status;
  final String? firId;

  const FIREntity({
    this.complaintType,
    this.description,
    this.dateTime,
    this.location,
    this.evidencePaths,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.status,
    this.firId,
  });

  FIREntity copyWith({
    String? complaintType,
    String? description,
    DateTime? dateTime,
    String? location,
    List<String>? evidencePaths,
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? status,
    String? firId,
  }) {
    return FIREntity(
      complaintType: complaintType ?? this.complaintType,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      location: location ?? this.location,
      evidencePaths: evidencePaths ?? this.evidencePaths,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      status: status ?? this.status,
      firId: firId ?? this.firId,
    );
  }

  @override
  List<Object?> get props => [
        complaintType,
        description,
        dateTime,
        location,
        evidencePaths,
        userId,
        userName,
        userEmail,
        userPhone,
        status,
        firId,
      ];
}
