// lib/models/get_message_model.dart

class GetMessageModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<MessageModel> data;

  GetMessageModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetMessageModel.fromJson(Map<String, dynamic> json) => GetMessageModel(
    statusCode: json['statusCode'],
    success: json['success'],
    message: json['message'],
    data: List<MessageModel>.from(
      json['data'].map((e) => MessageModel.fromJson(e)),
    ),
  );
}

// ─────────────────────────────────────────────
class MessageModel {
  final String id;
  final MessageUserModel sender;
  final MessageUserModel receiver;
  final String chatId;
  final String message;
  final String messageType; // "text" | "image" | "file" | "audio"
  final String? fileUrl;
  final bool isRead;
  final String createdAt;
  final String updatedAt;

  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.chatId,
    required this.message,
    required this.messageType,
    this.fileUrl,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  // Handles both the REST list shape (full {_id, name} sender/receiver
  // objects) and a flatter live-socket payload (e.g. plain senderId/
  // receiverId strings, missing _id/updatedAt) — a socket event that
  // doesn't match the REST shape used to throw here and get swallowed
  // silently, which is why a message a receiver was live in the chat for
  // never showed up until they left and reopened it.
  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['_id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString(),
    sender: _parseUser(json['sender'], json['senderId']),
    receiver: _parseUser(json['receiver'], json['receiverId']),
    chatId: json['chatId']?.toString() ?? '',
    message: json['message']?.toString() ?? '',
    messageType: json['messageType']?.toString() ?? 'text',
    fileUrl: json['fileUrl']?.toString(),
    isRead: json['isRead'] == true,
    createdAt: json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
    updatedAt: json['updatedAt']?.toString() ?? DateTime.now().toIso8601String(),
  );

  static MessageUserModel _parseUser(dynamic raw, dynamic fallbackId) {
    final primary = raw is Map
        ? MessageUserModel.fromJson(Map<String, dynamic>.from(raw))
        : MessageUserModel(id: _userId(raw), name: '');
    if (primary.id.isNotEmpty) return primary;

    final fallback = fallbackId is Map
        ? MessageUserModel.fromJson(Map<String, dynamic>.from(fallbackId))
        : MessageUserModel(id: _userId(fallbackId), name: '');
    return MessageUserModel(
      id: fallback.id,
      name: primary.name.isNotEmpty ? primary.name : fallback.name,
    );
  }

  static String _userId(dynamic value) {
    if (value is! String) return '';
    final id = value.trim();
    return id == 'null' ? '' : id;
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
    'chatId': chatId,
    'message': message,
    'messageType': messageType,
    'fileUrl': fileUrl,
    'isRead': isRead,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  MessageModel copyWith({
    String? id,
    MessageUserModel? sender,
    MessageUserModel? receiver,
    String? chatId,
    String? message,
    String? messageType,
    String? fileUrl,
    bool? isRead,
    String? createdAt,
    String? updatedAt,
  }) =>
      MessageModel(
        id: id ?? this.id,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        chatId: chatId ?? this.chatId,
        message: message ?? this.message,
        messageType: messageType ?? this.messageType,
        fileUrl: fileUrl ?? this.fileUrl,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  // ── Helpers
  static int compareNewestFirst(MessageModel a, MessageModel b) {
    final aTime = DateTime.tryParse(a.createdAt);
    final bTime = DateTime.tryParse(b.createdAt);
    if (aTime == null) return bTime == null ? 0 : 1;
    if (bTime == null) return -1;
    return bTime.compareTo(aTime);
  }

  bool isMine(String currentUserId) {
    final userId = _userId(currentUserId);
    return userId.isNotEmpty && _userId(sender.id) == userId;
  }
  bool get isImage => messageType == 'image';
  bool get isFile => messageType == 'file';
  bool get isAudio => messageType == 'audio';
  bool get isText => messageType == 'text';
}

// ─────────────────────────────────────────────
class MessageUserModel {
  final String id;
  final String name;

  MessageUserModel({
    required this.id,
    required this.name,
  });

  factory MessageUserModel.fromJson(Map<String, dynamic> json) => MessageUserModel(
    id: MessageModel._userId(json['_id']).isNotEmpty
        ? MessageModel._userId(json['_id'])
        : MessageModel._userId(json['id']),
    name: json['name']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}
