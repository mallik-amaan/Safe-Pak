part of 'alert_cubit.dart';

sealed class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

final class AlertInitial extends AlertState {}

final class AlertLoading extends AlertState {}

final class AlertsLoaded extends AlertState {
  final List<CriminalAlertEntity> alerts;

  const AlertsLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}

final class AlertError extends AlertState {
  final String message;

  const AlertError(this.message);

  @override
  List<Object> get props => [message];
}

final class AlertAdded extends AlertState {}
