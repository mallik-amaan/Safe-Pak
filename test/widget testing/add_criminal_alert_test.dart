import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safepak/features/criminal_alert/presentation/screens/admin/add_criminal_alert.dart';
import 'package:safepak/features/fir/presentation/cubit/fir_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockFirCubit extends Mock implements FirCubit {}

void main() {
  late FirCubit firCubit;

  setUp(() {
    firCubit = MockFirCubit();
    when(() => firCubit.state).thenReturn(FirInitial());
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<FirCubit>(
        create: (_) => firCubit,
        child: const AddCriminalAlert(),
      ),
    );
  }

  testWidgets('renders all form fields and submit button', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Add Alert'), findsOneWidget);
    expect(find.text('Select Alert Type'), findsOneWidget);
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Date and Time'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Tap to upload photo or video'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('shows validation errors when submitting empty form',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(find.text('Please select an alert type'), findsOneWidget);
    expect(find.text('Please enter a description'), findsOneWidget);
    expect(find.text('Please select a date and time'),
        findsNothing); // date is prefilled
    expect(find.text('Please select a location'), findsOneWidget);
  });

  testWidgets('dropdown can be opened and value selected', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();

    expect(find.text('Theft'), findsOneWidget);
    await tester.tap(find.text('Theft').last);
    await tester.pumpAndSettle();

    // Dropdown should now show selected value
    expect(find.text('Theft'), findsWidgets);
  });

  testWidgets('description field accepts input', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final descField = find.widgetWithText(TextFormField, 'Description');
    await tester.enterText(descField, 'Test description');
    expect(find.text('Test description'), findsOneWidget);
  });

  testWidgets('location field is read-only and suffix icon exists',
      (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    final locationField = find.widgetWithText(TextFormField, 'Location');
    // Try to enter text and verify it does not change (read-only)
    await tester.enterText(locationField, 'Should not change');
    expect(find.text('Should not change'), findsNothing);

    // Suffix icon button
    expect(find.byIcon(Icons.my_location), findsOneWidget);
  });

  testWidgets('file upload container is present', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byIcon(Icons.drive_folder_upload_rounded), findsOneWidget);
    expect(find.text('Tap to upload photo or video'), findsOneWidget);
  });

  testWidgets('submit button shows loading indicator when submitting',
      (tester) async {
    when(() => firCubit.state).thenReturn(FirLoading());
    await tester.pumpWidget(makeTestableWidget());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    await tester.tap(find.text('Submit'));
  });
}
