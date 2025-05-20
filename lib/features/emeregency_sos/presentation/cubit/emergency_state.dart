part of 'emergency_cubit.dart';

sealed class EmergencyState extends Equatable {
  const EmergencyState();

  
}

final class EmergencyInitial extends EmergencyState {
  @override
  List<Object> get props => [];
}
final class EmergencyContactAdded extends EmergencyState {
  @override
  List<Object> get props => [];
}

final class EmergencyContactsLoaded extends EmergencyState {
  final List<EmergencyContactEntity> contacts; 

  const EmergencyContactsLoaded(this.contacts);

  @override
  List<Object> get props => [contacts];
}

final class EmergencyLoading extends EmergencyState {
  @override
  List<Object> get props => [];
}

final class EmergencyError extends EmergencyState {
  final String message;

  const EmergencyError(this.message);

  @override
  List<Object> get props => [message];
}