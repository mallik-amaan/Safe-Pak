import 'package:dartz/dartz.dart';

import '../../../../core/common/classes/failure.dart' show Failure;
import '../../../../core/common/classes/no_params.dart';
import '../../domain/entities/user_entity.dart';


abstract class AuthRemoteDataSource{
  Future<Either<Failure,UserEntity>> signInWithEmailAndPassword(String email, String password);
  Future<Either<Failure,UserEntity>> signUpWithEmailAndPassword(String email, String password,String name);

  Future<Either<Failure,UserEntity>> signInWithGoogle(bool isSignUp);

  Future<Either> signOut();

  Future<Either<Failure,UserEntity>> updateUser(UserEntity user);

  Future<Either<Failure,UserEntity>> getUser();

  Future<Either<Failure,NoParams>> forgotPassword(String email);

  Future<Either<Failure,NoParams>> deleteAccount();
}