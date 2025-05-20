import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safepak/features/criminal_alert/presentation/screens/criminal_alert.dart';

void main() {
  testWidgets('CriminalAlertPage displays title and subtitle',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CriminalAlertPage(),
      ),
    );

    expect(find.text('Criminal Alerts'), findsOneWidget);
    expect(find.text('Nearby suspicious activities'), findsOneWidget);
  });

  testWidgets('CriminalAlertPage displays all criminal alerts',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CriminalAlertPage(),
      ),
    );

    // There are 4 alerts in the list
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(4));
    expect(find.text('Armed Robbery Suspect'), findsOneWidget);
    expect(find.text('Suspicious Person'), findsNWidgets(3));
    expect(
        find.textContaining('Last seen near Central Park'), findsNWidgets(3));
    expect(find.text('Last seen near Central Market wearing black jacket'),
        findsOneWidget);
  });

  testWidgets('CriminalAlertPage has an AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
       MaterialApp(
        home: CriminalAlertPage(),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
  });
}
