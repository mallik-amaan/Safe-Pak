import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:safepak/FIR Registration/track_fir_screen.dart';
import 'package:mockito/mockito.dart';

class MockUser {
  final String uid;
  MockUser({required this.uid});
}

// Fake DocumentSnapshot for testing
class FakeDocumentSnapshot {
  final Map<String, dynamic> _data;
  FakeDocumentSnapshot({required Map<String, dynamic> data}) : _data = data;

  Map<String, dynamic>? data() => _data;
}

class MockAuth extends Mock {
  MockUser? get currentUser => null;
}

class MockFirestore extends Mock {
  CollectionReferenceMock collection(String path) => CollectionReferenceMock();
}

class CollectionReferenceMock extends Mock {
  DocumentReferenceMock doc(String id) => DocumentReferenceMock();
}

class DocumentReferenceMock extends Mock {
  Future<FakeDocumentSnapshot> get() async =>
      FakeDocumentSnapshot(data: {'status': 'under review'});
}

void main() {
  testWidgets('TrackFirScreen displays initial state correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TrackFirScreen()));

    expect(find.text('Track your FIR'), findsOneWidget);
    // Mock Firestore response
    final mockUser = MockUser(uid: 'test123');

    // Define mock objects for auth and firestore
    final authMock = MockAuth();
    final firestoreMock = MockFirestore();

    when(authMock.currentUser).thenReturn(mockUser);
    when(firestoreMock.collection('fir_reports').doc('test123').get())
        .thenAnswer((_) async =>
            FakeDocumentSnapshot(data: {'status': 'under review'}));

    await tester.pumpWidget(MaterialApp(home: TrackFirScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Status:'), findsOneWidget);
    expect(find.text('under review'), findsOneWidget);
  });
  testWidgets('TrackFirScreen displays initial state correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TrackFirScreen()));

    expect(find.text('Track your FIR'), findsOneWidget);
    expect(find.text('Progress:'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
    expect(find.text('Status:'), findsOneWidget);
    expect(
        find.text(
            'Your FIR has been filled and is currently being reviewed by our team.'),
        findsOneWidget);
  });

  testWidgets('TrackFirScreen updates progress based on status',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TrackFirScreen()));

    // Mock Firestore response
    final mockUser = MockUser(uid: 'test123');

    // Define mock objects for auth and firestore
    final authMock = MockAuth();
    final firestoreMock = MockFirestore();

    when(authMock.currentUser).thenReturn(mockUser);
    when(firestoreMock.collection('fir_reports').doc('test123').get())
        .thenAnswer((_) async =>
            FakeDocumentSnapshot(data: {'status': 'under review'}));

    await tester.pumpAndSettle();

    expect(find.text('Status:'), findsOneWidget);
    expect(find.text('under review'), findsOneWidget);
  });

  testWidgets('TrackFirScreen shows message when no FIR found',
      (WidgetTester tester) async {
    // Mock Firestore response
    final mockUser = MockUser(uid: 'test123');
    final authMock = MockAuth();
    final firestoreMock = MockFirestore();

    when(authMock.currentUser).thenReturn(mockUser);
    when(firestoreMock.collection('fir_reports').doc('test123').get())
        .thenAnswer((_) async => FakeDocumentSnapshot(
              data: {}, /* exists: false */
            ));

    await tester.pumpWidget(MaterialApp(home: TrackFirScreen()));
    await tester.pumpAndSettle();

    expect(find.text('No FIR found for this user.'), findsOneWidget);
  });
  
}
