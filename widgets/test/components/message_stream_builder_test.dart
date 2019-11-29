import 'dart:async';
import 'package:flash_chat_widgets/components/message_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MessageStreamBuilderWrapper extends StatelessWidget {
  const MessageStreamBuilderWrapper(this._stream, this._builder);

  final Stream<dynamic> _stream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) _builder;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MessageStreamBuilderTest',
      home: MessageStreamBuilder(stream: _stream, builder: _builder),
    );
  }
}

void main() {
  final StreamController<String> streamController = StreamController<String>();

  final Stream<String> stream = streamController.stream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) builder =
      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Container();
  };

  Widget buildMessageStreamBuilder(Stream<dynamic> stream,
          Function(BuildContext, AsyncSnapshot<dynamic>) builder) =>
      MessageStreamBuilderWrapper(stream, builder);

  group('constructor', () {
    test('null stream throws error', () {
      try {
        MessageStreamBuilder(stream: null, builder: builder);
      } catch (error) {
        assert(error is AssertionError);
      }
    });

    test('null builder throws error', () {
      try {
        MessageStreamBuilder(stream: stream, builder: null);
      } catch (error) {
        assert(error is AssertionError);
      }
    });
  });

  testWidgets('builds widget with stream and builder',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMessageStreamBuilder(stream, builder));

    await tester.pump();

    expect(find.byType(MessageStreamBuilder), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });
}
