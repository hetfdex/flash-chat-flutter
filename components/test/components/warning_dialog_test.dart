import 'package:components/components/invalid_field_dialog.dart';
import 'package:components/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class InvalidFieldDialogWrapper extends StatelessWidget {
  const InvalidFieldDialogWrapper({this.invalidField});

  final InvalidField invalidField;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvalidFieldDialogTest',
      home: Builder(
        builder: (BuildContext context) => FlatButton(
          child: Text('showInvalidFieldDialog'),
          onPressed: () => showInvalidFieldDialog(context, invalidField),
        ),
      ),
    );
  }
}

void main() {
  Widget buildInvalidFieldDialog({InvalidField invalidField}) =>
      InvalidFieldDialogWrapper(invalidField: invalidField);

  testWidgets('null invalid input field throws error',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildInvalidFieldDialog(invalidField: null));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    expect(tester.takeException(), isArgumentError);
  });

  testWidgets('builds widget with email invalid input field',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(buildInvalidFieldDialog(invalidField: InvalidField.email));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(emailTitleText), findsOneWidget);
    expect(find.text(emailContentText), findsOneWidget);
  });

  testWidgets('builds widget with password invalid input field',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        buildInvalidFieldDialog(invalidField: InvalidField.pasword));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text(passwordTitleText), findsOneWidget);
    expect(find.text(passwordContentText), findsOneWidget);
  });

  testWidgets('tap dismisses widget', (WidgetTester tester) async {
    await tester
        .pumpWidget(buildInvalidFieldDialog(invalidField: InvalidField.email));

    await tester.pump();

    expect(find.byType(FlatButton), findsOneWidget);

    await tester.tap(find.byType(FlatButton));

    await tester.pump();

    await tester.tap(find.text('OK'));

    await tester.pump();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
