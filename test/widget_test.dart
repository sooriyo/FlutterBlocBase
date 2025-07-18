import 'package:flutter/material.dart';
import 'package:flutter_bloc_base/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc_base/core/di/injection.dart';

void main() {
  setUp(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory(),
    );
    await setupDependencies();
  });

  testWidgets('LoginPage displays and handles login', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsNWidgets(2));

    // Enter email and password
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.pump();

    // Tap the Login button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, User 123'), findsOneWidget);
  });
}