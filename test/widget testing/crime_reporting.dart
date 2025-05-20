import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safepak/features/fir/presentation/pages/fir_registration_page.dart';

void main() {
  testWidgets('FirRegistrationPage displays form fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FirRegistrationPage()));

    expect(find.text('Report a Crime'), findsOneWidget);
    expect(find.byType(TextFormField),
        findsNWidgets(3)); // Assuming 3 fields: title, description, location
    expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);
  });

  testWidgets('FirRegistrationPage shows validation errors',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FirRegistrationPage()));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();

    expect(find.text('Please enter a title'), findsOneWidget);
    expect(find.text('Please enter a description'), findsOneWidget);
    expect(find.text('Please enter a location'), findsOneWidget);
  });

  testWidgets('FirRegistrationPage submits form with valid input',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FirRegistrationPage()));

    await tester.enterText(find.byKey(Key('titleField')), 'Robbery');
    await tester.enterText(find.byKey(Key('descriptionField')),
        'A robbery occurred at the market.');
    await tester.enterText(find.byKey(Key('locationField')), 'Main Street');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();

    // Assuming a success message/snackbar is shown
    expect(find.text('Crime reported successfully!'), findsOneWidget);
  });

  testWidgets('FirRegistrationPage resets form after submission',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FirRegistrationPage()));

    await tester.enterText(find.byKey(Key('titleField')), 'Robbery');
    await tester.enterText(find.byKey(Key('descriptionField')),
        'A robbery occurred at the market.');
    await tester.enterText(find.byKey(Key('locationField')), 'Main Street');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();

    expect(find.text('Robbery'), findsNothing);
    expect(find.text('A robbery occurred at the market.'), findsNothing);
    expect(find.text('Main Street'), findsNothing);
  });
}
