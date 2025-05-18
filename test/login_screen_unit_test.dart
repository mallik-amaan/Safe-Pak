// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// // Mock classes
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}
// class MockUserCredential extends Mock implements UserCredential {}
// class MockUser extends Mock implements User {}

// void main() {
//   late MockFirebaseAuth mockFirebaseAuth;
//   late MockUserCredential mockUserCredential;
//   late MockUser mockUser;
//   late _LoginScreenState loginScreenState;
//   late TextEditingController emailController;
//   late TextEditingController passwordController;

//   setUp(() {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockUserCredential = MockUserCredential();
//     mockUser = MockUser();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();

//     // Initialize the state
//     loginScreenState = _LoginScreenState();
//     loginScreenState._auth = mockFirebaseAuth;
//     loginScreenState._emailController = emailController;
//     loginScreenState._passwordController = passwordController;

//     // Mock Firebase Auth behavior
//     when(mockUserCredential.user).thenReturn(mockUser);
//     when(mockUser.emailVerified).thenReturn(true);
//   });

//   group('LoginScreen Unit Tests', () {
//     test('validateInputs returns false when email is empty', () {
//       emailController.text = '';
//       passwordController.text = 'password123';

//       expect(loginScreenState._validateInputs(), false);
//     });

//     test('validateInputs returns false when password is empty', () {
//       emailController.text = 'test@example.com';
//       passwordController.text = '';

//       expect(loginScreenState._validateInputs(), false);
//     });

//     test('validateInputs returns true when inputs are valid', () {
//       emailController.text = 'test@example.com';
//       passwordController.text = 'password123';

//       expect(loginScreenState._validateInputs(), true);
//     });

//     test('login does not call FirebaseAuth when inputs are invalid', () async {
//       emailController.text = '';
//       passwordController.text = '';

//       await loginScreenState._login();

//       verifyNever(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: anyNamed('email'),
//         password: anyNamed('password'),
//       ));
//     });

//     test('login calls FirebaseAuth with correct credentials', () async {
//       emailController.text = 'test@example.com';
//       passwordController.text = 'password123';

//       await loginScreenState._login();

//       verify(mockFirebaseAuth.signInWithEmailAndPassword(
//         email: 'test@example.com',
//         password: 'password123',
//       )).called(1);
//     });

//     test('login does not proceed if email is not verified', () async {
//       when(mockUser.emailVerified).thenReturn(false);
//       emailController.text = 'test@example.com';
//       passwordController.text = 'password123';

//       await loginScreenState._login();

//       verify(mockFirebaseAuth.signOut()).called(1);
//     });
//   });
// }