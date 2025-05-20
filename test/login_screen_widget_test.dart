import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safepak/features/authentication/presentation/pages/login_page.dart';
import 'package:safepak/features/authentication/presentation/pages/register_page.dart';
import 'package:safepak/features/home/pages/home_page.dart';

// Mock classes
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockFluttertoast extends Mock implements Fluttertoast {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockNavigatorObserver = MockNavigatorObserver();

    when(mockUserCredential.user).thenReturn(mockUser);
    when(mockUser.emailVerified).thenReturn(true);
    when(mockUser.displayName).thenReturn('Test User');
    when(mockUser.email).thenReturn('test@example.com');
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: child,
      navigatorObservers: [mockNavigatorObserver],
      theme: ThemeData(
        primaryColor: Colors.blue,
        shadowColor: Colors.blueAccent,
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('displays all UI elements', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      expect(find.text('Safe-Pak'), findsOneWidget);
      expect(find.byIcon(Icons.security), findsOneWidget);
      expect(find.byIcon(Icons.email), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Don’t have an account? Register here'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('shows loading indicator during login', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('navigates to HomeScreen on successful login', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verify(mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      )).called(1);
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('navigates to RegisterScreen when register link tapped', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      await tester.tap(find.text('Don’t have an account? Register here'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets('does not attempt login when inputs are empty', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(LoginPage()));

      await tester.tap(find.text('Login'));
      await tester.pump();

    });

    testWidgets('handles unverified email', (WidgetTester tester) async {
      when(mockUser.emailVerified).thenReturn(false);

      await tester.pumpWidget(buildTestWidget(LoginPage()));

      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verify(mockFirebaseAuth.signOut()).called(1);
      expect(find.byType(HomePage), findsNothing);
    });
  });
}