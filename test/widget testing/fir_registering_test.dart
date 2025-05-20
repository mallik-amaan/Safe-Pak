import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safepak/features/fir/presentation/pages/fir_registration_page.dart';

void main() {
  group('FIRRegistrationPage Widget Tests', () {
    testWidgets('Renders all required input fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FirRegistrationPage(),
        ),
      );

      expect(find.text('Register FIR'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4)); // Adjust if more/less fields
      expect(find.widgetWithText(TextFormField, 'Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Contact Number'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Incident Details'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Location'), findsOneWidget);
    });

    testWidgets('Submit button is present and enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FirRegistrationPage(),
        ),
      );

      final submitButton = find.widgetWithText(ElevatedButton, 'Submit');
      expect(submitButton, findsOneWidget);
      expect(tester.widget<ElevatedButton>(submitButton).enabled, isTrue);
    });

    testWidgets('Shows validation error when fields are empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FirRegistrationPage(),
        ),
      );

      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pump();

      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please enter your contact number'), findsOneWidget);
      expect(find.text('Please enter incident details'), findsOneWidget);
      expect(find.text('Please enter location'), findsOneWidget);
    });

    testWidgets('Form submits with valid input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FirRegistrationPage(),
        ),
      );

      await tester.enterText(find.widgetWithText(TextFormField, 'Name'), 'John Doe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Contact Number'), '1234567890');
      await tester.enterText(find.widgetWithText(TextFormField, 'Incident Details'), 'Test incident');
      await tester.enterText(find.widgetWithText(TextFormField, 'Location'), 'Test location');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pump();

      // You may want to check for a success message/snackbar/dialog
      expect(find.text('FIR submitted successfully'), findsOneWidget);
    });
  });
}