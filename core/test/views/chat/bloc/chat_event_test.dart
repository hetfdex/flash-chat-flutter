import 'package:flash_chat_core/views/chat/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatSubmitted', () {
    test('should return correct string override', () {
      const expectedString = 'ChatSubmitted';

      final chatSubmitted = ChatSubmitted(null);

      expect(chatSubmitted.toString(), expectedString);
    });

    test('props returns message', () {
      const message = 'message';

      final chatSubmitted = ChatSubmitted(message);

      expect(chatSubmitted.props, [message]);
    });
  });

  group('ChatChanged', () {
    test('should return correct string override', () {
      const expectedString = 'ChatChanged';

      final chatChanged = ChatChanged(null);

      expect(chatChanged.toString(), expectedString);
    });

    test('props returns message', () {
      const message = 'message';

      final chatChanged = ChatChanged(message);

      expect(chatChanged.props, [message]);
    });
  });

  group('CloseButtonPressed', () {
    test('should return correct string override', () {
      const expectedString = 'CloseButtonPressed';

      final closeButtonPressed = CloseButtonPressed();

      expect(closeButtonPressed.toString(), expectedString);
    });

    test('props returns null', () {
      final closeButtonPressed = CloseButtonPressed();

      expect(closeButtonPressed.props, null);
    });
  });
}
