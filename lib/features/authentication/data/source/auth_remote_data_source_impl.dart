import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safepak/core/common/classes/failure.dart';
import 'package:safepak/core/common/classes/no_params.dart';
import 'package:safepak/core/configs/services/user_singleton.dart';
import 'package:safepak/features/authentication/data/source/auth_remote_data_source.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';

import '../models/user_model.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  AuthRemoteDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseAuth});
  @override
  Future<Either<Failure, NoParams>> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NoParams>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await firebaseFirestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          final data = userDoc.data()!;
          final UserEntity user = UserModel.fromJson(data);
          UserSingleton().saveUser(user);
          return Right(user);
        } else {
          return Left(Failure(message: "User data not found in Firestore"));
        }
      } else {
        return Left(Failure(message: "User not found"));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";

      if (e.code == 'user-not-found') {
        errorMessage = "Invalid email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Invalid password.";
      }
      return Left(Failure(message: errorMessage));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle(bool isSignUp) {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        UserModel createdUser = UserModel(name: name, email: email, uid: user.uid);
        await firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .set(createdUser.toJson());
        UserEntity newUser = UserEntity(name: name, email: email, uid: user.uid);
        await UserSingleton().saveUser(newUser);
        return Right(newUser);
      } else {
        return Left(Failure(message: "Could not create user"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user) async{
    try{
    // await UploadFile.uploadFile(user.image!);
    await firebaseFirestore.collection('users').doc(user.uid).update(
      {'email': user.email,
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'imageUrl': user.imageUrl,
        'dob': user.dob,
        'province': user.province,
        'address': user.address,
        'city': user.city,
        'gender':user.gender,
      });
      DocumentSnapshot snap =await firebaseFirestore.collection('users').doc(user.uid).get();
      UserEntity newUser = UserModel.fromJson(snap.data() as Map<String,dynamic>);
      await UserSingleton().saveUser(newUser);
      return Right(newUser);
    }on FirebaseException catch(e){
      return Left(Failure(message: e.toString()));
    }
    catch(e){
      return Left(Failure(message: e.toString()));
    }
  }
}
