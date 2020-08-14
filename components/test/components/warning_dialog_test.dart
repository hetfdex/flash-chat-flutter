import 'package:components/components/warning_dialog.dart';
import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WarningDialogWrapper extends StatelessWidget {
  const WarningDialogWrapper({this.warnings});

  final Warnings warnings;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WarningDialogTest',
      home: Builder(
        builder: (context) => FlatButton(
          child: Text('showWarningDialog'),
          onPressed: () => showWarningDialog(context, warnings),
        ),
      ),
    );
  }
}

void main() {
  Widget buildWarningDialog({Warnings warnings}) =>
      WarningDialogWrapper(warnings: warnings);

  testWidgets('null warnings throws error', (tester) async {
    await tester.pumpWidget(buildWarningDialog(warnings: null));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    expect(tester.takeException(), isArgumentError);
  });

  testWidgets('builds widget with invalid email warning', (tester) async {
    await tester
        .pumpWidget(buildWarningDialog(warnings: Warnings.invalidEmail));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(invalidEmailTitle), findsOneWidget);
    expect(find.text(invalidEmailContent), findsOneWidget);
  });

  testWidgets('builds widget with invalid password warning', (tester) async {
    await tester
        .pumpWidget(buildWarningDialog(warnings: Warnings.invalidPassword));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(invalidPasswordTitle), findsOneWidget);
    expect(find.text(invalidPasswordContent), findsOneWidget);
  });

  testWidgets('builds widget with unknown user warning', (tester) async {
    await tester.pumpWidget(buildWarningDialog(warnings: Warnings.unknownUser));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(unknownUserTitle), findsOneWidget);
    expect(find.text(unknownUserContent), findsOneWidget);
  });

  testWidgets('builds widget with wrong password warning', (tester) async {
    await tester
        .pumpWidget(buildWarningDialog(warnings: Warnings.wrongPassword));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(wrongPasswordTitle), findsOneWidget);
    expect(find.text(wrongPasswordContent), findsOneWidget);
  });

  testWidgets('tap dismisses widget', (tester) async {
    await tester
        .pumpWidget(buildWarningDialog(warnings: Warnings.invalidEmail));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    await tester.tap(find.text('OK'));

    await tester.pump();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
