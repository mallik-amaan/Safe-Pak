import 'package:equatable/equatable.dart';

class EmergencyContactEntity extends Equatable{
  final String? name;
  final String? phoneNumber;
  final String? relation;
  final bool? isPrimary;

  const EmergencyContactEntity({
    this.name,
    this.phoneNumber,
    this.relation,
    this.isPrimary,
  });

  @override
  List<Object?> get props => [name, phoneNumber, relation, isPrimary];
}