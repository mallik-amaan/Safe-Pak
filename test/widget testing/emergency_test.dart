import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:safepak/features/emeregency_sos/presentation/screens/emergency_details.dart';
import 'package:safepak/features/emeregency_sos/presentation/cubit/emergency_cubit.dart';
import 'package:safepak/features/emeregency_sos/presentation/widgets/emergency_contact_detail_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';

class MockEmergencyCubit extends Mock implements EmergencyCubit {}

void main() {
  late MockEmergencyCubit mockEmergencyCubit;

  setUp(() {
    mockEmergencyCubit = MockEmergencyCubit();
  });

  group('EmergencyDetailsScreen Widget Tests', () {
    testWidgets('renders all form fields correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmergencyCubit>.value(
            value: mockEmergencyCubit,
            child: EmergencyDetailsScreen(),
          ),
        ),
      );

      expect(find.text('Emergency Contacts'), findsOneWidget);
      expect(find.text('Add trusted contacts for emergencies'), findsOneWidget);
      expect(find.byType(EmergencyContactDetailField), findsNWidgets(3));
      expect(find.text('Contact Name'), findsOneWidget);
      expect(find.text('Relationship'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
    });

    testWidgets('shows validation errors for empty fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmergencyCubit>.value(
            value: mockEmergencyCubit,
            child: EmergencyDetailsScreen(),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Please enter a name'), findsOneWidget);
      expect(find.text('Please enter a relationship'), findsOneWidget);
      expect(find.text('Please enter a phone number'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid phone number',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmergencyCubit>.value(
            value: mockEmergencyCubit,
            child: EmergencyDetailsScreen(),
          ),
        ),
      );

      // Enter invalid phone number (less than 11 digits)
      await tester.enterText(
          find.widgetWithText(EmergencyContactDetailField, 'Phone Number'),
          '12345');
      await tester.pump();

      expect(find.text('Enter a valid 11-digit phone number'), findsOneWidget);
    });

    testWidgets('calls addEmergencyContact with valid data',
        (WidgetTester tester) async {
      when(mockEmergencyCubit.state).thenReturn(EmergencyInitial());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmergencyCubit>.value(
            value: mockEmergencyCubit,
            child: EmergencyDetailsScreen(),
          ),
        ),
      );

      // Enter valid data
      await tester.enterText(
          find.widgetWithText(EmergencyContactDetailField, 'Contact Name'),
          'John Doe');
      await tester.enterText(
          find.widgetWithText(EmergencyContactDetailField, 'Relationship'),
          'Father');
      await tester.enterText(
          find.widgetWithText(EmergencyContactDetailField, 'Phone Number'),
          '03001234567');

      await tester.pump();

      verify(mockEmergencyCubit.addEmergencyContact(
        EmergencyContactEntity(
          name: 'John Doe',
          relation: 'Father',
          phoneNumber: '03001234567',
          isPrimary: true,
        ),
      )).called(1);
    });

    testWidgets('shows loading indicator when submitting',
        (WidgetTester tester) async {
      when(mockEmergencyCubit.state).thenReturn(EmergencyLoading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmergencyCubit>.value(
            value: mockEmergencyCubit,
            child: EmergencyDetailsScreen(),
          ),
        ),
      );

      // Replace 'LoadingIndicator' with the correct loading widget used in your EmergencyDetailsScreen, e.g., CircularProgressIndicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
