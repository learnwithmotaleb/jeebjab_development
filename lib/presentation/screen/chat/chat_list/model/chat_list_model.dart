// lib/models/chat_list_model.dart

class ChatListModel {
  final int statusCode;
  final bool success;
  final String message;
  final List<ChatModel> data;

  ChatListModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
    statusCode: json['statusCode'],
    success: json['success'],
    message: json['message'],
    data: List<ChatModel>.from(json['data'].map((e) => ChatModel.fromJson(e))),
  );
}

// ─────────────────────────────────────────────
class ChatModel {
  final String id;
  final List<String> participants;
  final String createdAt;
  final String updatedAt;
  final String? lastMessage;
  final int unreadCount;
  final List<ParticipantModel> participantDetails;
  final LastMessageModel? lastMessageDetails;

  ChatModel({
    required this.id,
    required this.participants,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
    required this.unreadCount,
    required this.participantDetails,
    this.lastMessageDetails,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json['_id'],
    participants: List<String>.from(json['participants']),
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    lastMessage: json['lastMessage'],
    unreadCount: json['unreadCount'] ?? 0,
    participantDetails: List<ParticipantModel>.from(
      json['participantDetails'].map((e) => ParticipantModel.fromJson(e)),
    ),
    lastMessageDetails: json['lastMessageDetails'] != null
        ? LastMessageModel.fromJson(json['lastMessageDetails'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'participants': participants,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'lastMessage': lastMessage,
    'unreadCount': unreadCount,
    'participantDetails': participantDetails.map((e) => e.toJson()).toList(),
    'lastMessageDetails': lastMessageDetails?.toJson(),
  };

  ChatModel copyWith({
    String? id,
    List<String>? participants,
    String? createdAt,
    String? updatedAt,
    String? lastMessage,
    int? unreadCount,
    List<ParticipantModel>? participantDetails,
    LastMessageModel? lastMessageDetails,
  }) =>
      ChatModel(
        id: id ?? this.id,
        participants: participants ?? this.participants,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastMessage: lastMessage ?? this.lastMessage,
        unreadCount: unreadCount ?? this.unreadCount,
        participantDetails: participantDetails ?? this.participantDetails,
        lastMessageDetails: lastMessageDetails ?? this.lastMessageDetails,
      );
}

// ─────────────────────────────────────────────
class ParticipantModel {
  final String id;
  final String authId;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? avatar;
  final String? gender;
  final String? dateOfBirth;
  final String language;
  final double ratingAsAdvertiser;
  final bool isPhoneVerified;
  final dynamic defaultAddress;
  final DriverProfileModel? driverProfile;
  final bool isOnline;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final String? activeMode;

  ParticipantModel({
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.avatar,
    this.gender,
    this.dateOfBirth,
    required this.language,
    required this.ratingAsAdvertiser,
    required this.isPhoneVerified,
    this.defaultAddress,
    this.driverProfile,
    required this.isOnline,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    this.activeMode,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) => ParticipantModel(
    id: json['_id'],
    authId: json['authId'],
    name: json['name'],
    email: json['email'],
    phoneNumber: json['phoneNumber'],
    avatar: json['avatar'],
    gender: json['gender'],
    dateOfBirth: json['dateOfBirth'],
    language: json['language'] ?? 'en',
    ratingAsAdvertiser: (json['ratingAsAdvertiser'] ?? 0).toDouble(),
    isPhoneVerified: json['isPhoneVerified'] ?? false,
    defaultAddress: json['defaultAddress'],
    driverProfile: json['driverProfile'] != null
        ? DriverProfileModel.fromJson(json['driverProfile'])
        : null,
    isOnline: json['isOnline'] ?? false,
    isDeleted: json['isDeleted'] ?? false,
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    activeMode: json['activeMode'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'authId': authId,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'avatar': avatar,
    'gender': gender,
    'dateOfBirth': dateOfBirth,
    'language': language,
    'ratingAsAdvertiser': ratingAsAdvertiser,
    'isPhoneVerified': isPhoneVerified,
    'defaultAddress': defaultAddress,
    'driverProfile': driverProfile?.toJson(),
    'isOnline': isOnline,
    'isDeleted': isDeleted,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'activeMode': activeMode,
  };
}

// ─────────────────────────────────────────────
class DriverProfileModel {
  final String driverType;
  final String? companyId;
  final String? companyDriverId;
  final String companyName;
  final String vehicleType;
  final String vehicleBrand;
  final String vehicleModel;
  final int vehicleYear;
  final String licenseNumber;
  final List<DriverDocumentModel> documents;
  final String approvalStatus;
  final String? approvedBy;
  final String? approvedAt;
  final String? rejectionNote;
  final bool isAvailable;
  final double averageRating;
  final int totalRatings;
  final int totalDeliveries;
  final String? lastLocationUpdatedAt;

  DriverProfileModel({
    required this.driverType,
    this.companyId,
    this.companyDriverId,
    required this.companyName,
    required this.vehicleType,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleYear,
    required this.licenseNumber,
    required this.documents,
    required this.approvalStatus,
    this.approvedBy,
    this.approvedAt,
    this.rejectionNote,
    required this.isAvailable,
    required this.averageRating,
    required this.totalRatings,
    required this.totalDeliveries,
    this.lastLocationUpdatedAt,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) => DriverProfileModel(
    driverType: json['driverType'] ?? '',
    companyId: json['companyId'],
    companyDriverId: json['companyDriverId'],
    companyName: json['companyName'] ?? '',
    vehicleType: json['vehicleType'] ?? '',
    vehicleBrand: json['vehicleBrand'] ?? '',
    vehicleModel: json['vehicleModel'] ?? '',
    vehicleYear: json['vehicleYear'] ?? 0,
    licenseNumber: json['licenseNumber'] ?? '',
    documents: List<DriverDocumentModel>.from(
      (json['documents'] ?? []).map((e) => DriverDocumentModel.fromJson(e)),
    ),
    approvalStatus: json['approvalStatus'] ?? 'pending',
    approvedBy: json['approvedBy'],
    approvedAt: json['approvedAt'],
    rejectionNote: json['rejectionNote'],
    isAvailable: json['isAvailable'] ?? false,
    averageRating: (json['averageRating'] ?? 0).toDouble(),
    totalRatings: json['totalRatings'] ?? 0,
    totalDeliveries: json['totalDeliveries'] ?? 0,
    lastLocationUpdatedAt: json['lastLocationUpdatedAt'],
  );

  Map<String, dynamic> toJson() => {
    'driverType': driverType,
    'companyId': companyId,
    'companyDriverId': companyDriverId,
    'companyName': companyName,
    'vehicleType': vehicleType,
    'vehicleBrand': vehicleBrand,
    'vehicleModel': vehicleModel,
    'vehicleYear': vehicleYear,
    'licenseNumber': licenseNumber,
    'documents': documents.map((e) => e.toJson()).toList(),
    'approvalStatus': approvalStatus,
    'approvedBy': approvedBy,
    'approvedAt': approvedAt,
    'rejectionNote': rejectionNote,
    'isAvailable': isAvailable,
    'averageRating': averageRating,
    'totalRatings': totalRatings,
    'totalDeliveries': totalDeliveries,
    'lastLocationUpdatedAt': lastLocationUpdatedAt,
  };
}

// ─────────────────────────────────────────────
class DriverDocumentModel {
  final String docType;
  final String url;
  final String uploadedAt;

  DriverDocumentModel({
    required this.docType,
    required this.url,
    required this.uploadedAt,
  });

  factory DriverDocumentModel.fromJson(Map<String, dynamic> json) => DriverDocumentModel(
    docType: json['docType'],
    url: json['url'],
    uploadedAt: json['uploadedAt'],
  );

  Map<String, dynamic> toJson() => {
    'docType': docType,
    'url': url,
    'uploadedAt': uploadedAt,
  };
}

// ─────────────────────────────────────────────
class LastMessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String chatId;
  final String message;
  final String messageType;
  final String? fileUrl;
  final bool isRead;
  final String createdAt;
  final String updatedAt;

  LastMessageModel({
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

  factory LastMessageModel.fromJson(Map<String, dynamic> json) => LastMessageModel(
    id: json['_id'],
    sender: json['sender'],
    receiver: json['receiver'],
    chatId: json['chatId'],
    message: json['message'],
    messageType: json['messageType'] ?? 'text',
    fileUrl: json['fileUrl'],
    isRead: json['isRead'] ?? false,
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'sender': sender,
    'receiver': receiver,
    'chatId': chatId,
    'message': message,
    'messageType': messageType,
    'fileUrl': fileUrl,
    'isRead': isRead,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}