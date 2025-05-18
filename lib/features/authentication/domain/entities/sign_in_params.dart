import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  final String email;
  final String password;
  final String name;

  const SignInParams({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password,name];
}