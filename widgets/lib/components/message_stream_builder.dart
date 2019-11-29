import 'package:flutter/material.dart';

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({@required this.stream, @required this.builder})
      : assert(stream != null),
        assert(builder != null);

  final Stream<dynamic> stream;

  final Function(BuildContext, AsyncSnapshot<dynamic>) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(stream: stream, builder: builder);
  }
}
