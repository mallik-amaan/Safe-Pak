part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class Authenticated extends AuthenticationState {
  final UserEntity user;
  final bool isSignupFromGoogle;

  const Authenticated({required this.user, this.isSignupFromGoogle = false});

  @override
  List<Object> get props => [user];
}

final class AuthenticatedButNotComplete extends AuthenticationState {
  final UserEntity user;
  // final bool isSignupFromGoogle;
  const AuthenticatedButNotComplete({required this.user,});

  @override
  List<Object> get props => [user];
}

final class UserUpdated extends AuthenticationState {
  final UserEntity user;

  const UserUpdated(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthenticationError extends AuthenticationState {
  final Failure message;

  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}

final class AccountDeleted extends AuthenticationState {}

final class NotAuthenticated extends AuthenticationState {}
final class ForgotPasswordSuccess extends AuthenticationState {}