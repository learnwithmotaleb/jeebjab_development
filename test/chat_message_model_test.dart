import 'package:flutter_test/flutter_test.dart';
import 'package:jeebjab/presentation/screen/chat/model/get_message_model.dart';
import 'package:jeebjab/presentation/screen/chat/chat_list/model/chat_list_model.dart';

void main() {
  test('REST and socket participant shapes preserve message ownership', () {
    for (final sender in ['me', {'_id': 'me'}, {'id': 'me'}]) {
      for (final key in ['sender', 'senderId']) {
        final json = <String, dynamic>{
          key: sender,
          'receiverId': {'_id': 'other'},
        };
        final message = MessageModel.fromJson(json);
        expect(message.isMine('me'), isTrue);
        expect(message.isMine('other'), isFalse);
        expect(message.receiver.id, 'other');
        expect(LastMessageModel.fromJson(json).sender, 'me');
      }
    }
  });

  test('missing IDs cannot match and empty sender uses senderId', () {
    expect(MessageModel.fromJson({}).isMine(''), isFalse);
    final message = MessageModel.fromJson({
      'sender': {'name': 'Me'},
      'senderId': {'_id': ' me '},
    });
    expect(message.isMine('me'), isTrue);
    expect(message.sender.name, 'Me');
  });

  test('mixed sent and received history sorts newest first across timezones', () {
    final messages = [
      MessageModel.fromJson({'sender': 'me', 'createdAt': '2026-09-05T10:00:00Z'}),
      MessageModel.fromJson({'sender': 'other', 'createdAt': '2026-09-05T16:02:00+06:00'}),
      MessageModel.fromJson({'sender': 'me', 'createdAt': '2026-09-05T10:01:00Z'}),
    ]..sort(MessageModel.compareNewestFirst);
    expect(messages.map((m) => m.createdAt), [
      '2026-09-05T16:02:00+06:00',
      '2026-09-05T10:01:00Z',
      '2026-09-05T10:00:00Z',
    ]);
  });
}
