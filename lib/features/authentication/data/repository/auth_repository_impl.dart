import 'package:dartz/dartz.dart';
import '../../../../core/common/classes/failure.dart';
import '../../../../core/common/classes/no_params.dart' show NoParams;
import '../../../../dependency_injection.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either<Failure,UserEntity>> signInWithEmailAndPassword(String email, String password)=> sl<AuthRemoteDataSource>().signInWithEmailAndPassword(email,password);

  @override
  Future<Either<Failure,UserEntity>> signInWithGoogle(bool isSignUp) => sl<AuthRemoteDataSource>().signInWithGoogle(isSignUp);

  @override
  Future<Either> signOut() => sl<AuthRemoteDataSource>().signOut();

  @override
  Future<Either<Failure,UserEntity>> signUpWithEmailAndPassword(String email, String password,String name) => sl<AuthRemoteDataSource>().signUpWithEmailAndPassword(email,password,name);
  
  @override
  Future<Either<Failure,UserEntity>> updateUser(UserEntity user) => sl<AuthRemoteDataSource>().updateUser(user);
  
  @override
  Future<Either<Failure, UserEntity>> getUser() => sl<AuthRemoteDataSource>().getUser();
  
  @override
  Future<Either<Failure, NoParams>> forgotPassword(String email) => sl<AuthRemoteDataSource>().forgotPassword(email);
  
  @override
  Future<Either<Failure, NoParams>> deleteAccount() => sl<AuthRemoteDataSource>().deleteAccount();
  
}