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

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json['_id'],
    sender: MessageUserModel.fromJson(json['sender']),
    receiver: MessageUserModel.fromJson(json['receiver']),
    chatId: json['chatId'],
    message: json['message'] ?? '',
    messageType: json['messageType'] ?? 'text',
    fileUrl: json['fileUrl'],
    isRead: json['isRead'] ?? false,
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

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
  bool isMine(String currentUserId) => sender.id == currentUserId;
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
    id: json['_id'],
    name: json['name'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
  };
}