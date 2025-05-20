import 'package:equatable/equatable.dart';

class EmergencyEntity extends Equatable{
  final String? name;
  final String? phoneNumber;
  final String? location;

  const EmergencyEntity({
    this.name,
    this.phoneNumber,
    this.location,
  });

  @override
  List<Object?> get props => [name, phoneNumber, location,];
}