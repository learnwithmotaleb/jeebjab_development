// lib/data/models/user_model.dart

import '../../../../../service/api_url.dart';

/// authId is populated (not just an id string) on both
/// GET /user/user-profile and GET /driver/profile.
class AuthModel {
  final String? email;
  final String? role; // "USER" | "DRIVER" | "ADMIN" | "SUPER_ADMIN"
  final bool? isActive;
  final bool? isBlocked;

  AuthModel({this.email, this.role, this.isActive, this.isBlocked});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    email: json['email']?.toString(),
    role: json['role']?.toString(),
    isActive: json['isActive'] as bool?,
    isBlocked: json['isBlocked'] as bool?,
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'role': role,
    'isActive': isActive,
    'isBlocked': isBlocked,
  };
}

class UserModel {
  final String id;
  final AuthModel? authId;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? avatar;
  final String? gender;
  final DateTime? dateOfBirth;
  final double ratingAsAdvertiser;
  final int totalRatingsAsAdvertiser;
  final String? activeMode; // "user" | "driver"
  final bool isOnline;
  final String? fcmToken;
  final bool isPhoneVerified;
  final String? defaultAddress;
  final DriverProfileModel? driverProfile;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    this.authId,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.avatar,
    this.gender,
    this.dateOfBirth,
    this.ratingAsAdvertiser = 0,
    this.totalRatingsAsAdvertiser = 0,
    this.activeMode,
    this.isOnline = false,
    this.fcmToken,
    this.isPhoneVerified = false,
    this.defaultAddress,
    this.driverProfile,
    this.isDeleted = false,
    this.createdAt,
    this.updatedAt,
  });

  /// Full avatar URL ready for Image.network()
  String? get avatarUrl => (avatar != null && avatar!.isNotEmpty)
      ? ApiUrl.buildImageUrl(avatar!)
      : null;

  bool get isDriver => driverProfile != null;
  String? get role => authId?.role;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // ── unwrap envelope if needed ──────────────────────────
    final d = json['data'] != null
        ? json['data'] as Map<String, dynamic>
        : json;

    return UserModel(
      id: d['_id']?.toString() ?? '',
      authId: d['authId'] is Map
          ? AuthModel.fromJson(d['authId'] as Map<String, dynamic>)
          : null,
      name: d['name']?.toString() ?? '',
      email: d['email']?.toString() ?? '',
      phoneNumber: d['phoneNumber']?.toString(),
      avatar: d['avatar']?.toString(),
      gender: d['gender']?.toString(),
      dateOfBirth: d['dateOfBirth'] != null
          ? DateTime.tryParse(d['dateOfBirth'].toString())
          : null,
      ratingAsAdvertiser: (d['ratingAsAdvertiser'] as num?)?.toDouble() ?? 0,
      totalRatingsAsAdvertiser:
          (d['totalRatingsAsAdvertiser'] as num?)?.toInt() ?? 0,
      activeMode: d['activeMode']?.toString(),
      isOnline: d['isOnline'] == true,
      fcmToken: d['fcmToken']?.toString(),
      isPhoneVerified: d['isPhoneVerified'] == true,
      defaultAddress: d['defaultAddress']?.toString(),
      driverProfile: d['driverProfile'] != null
          ? DriverProfileModel.fromJson(
              d['driverProfile'] as Map<String, dynamic>,
            )
          : null,
      isDeleted: d['isDeleted'] == true,
      createdAt: d['createdAt'] != null
          ? DateTime.tryParse(d['createdAt'].toString())
          : null,
      updatedAt: d['updatedAt'] != null
          ? DateTime.tryParse(d['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'authId': authId?.toJson(),
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'avatar': avatar,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'ratingAsAdvertiser': ratingAsAdvertiser,
    'totalRatingsAsAdvertiser': totalRatingsAsAdvertiser,
    'activeMode': activeMode,
    'isOnline': isOnline,
    'fcmToken': fcmToken,
    'isPhoneVerified': isPhoneVerified,
    'defaultAddress': defaultAddress,
    'driverProfile': driverProfile?.toJson(),
    'isDeleted': isDeleted,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? avatar,
    String? defaultAddress,
    DriverProfileModel? driverProfile,
    bool? isOnline,
    String? activeMode,
  }) {
    return UserModel(
      id: id,
      authId: authId,
      name: name ?? this.name,
      email: email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      gender: gender,
      dateOfBirth: dateOfBirth,
      ratingAsAdvertiser: ratingAsAdvertiser,
      totalRatingsAsAdvertiser: totalRatingsAsAdvertiser,
      activeMode: activeMode ?? this.activeMode,
      isOnline: isOnline ?? this.isOnline,
      fcmToken: fcmToken,
      isPhoneVerified: isPhoneVerified,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      driverProfile: driverProfile ?? this.driverProfile,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

// lib/data/models/driver_profile_model.dart

class DriverProfileModel {
  final String driverType; // "independent" | "company"
  final String? companyId;
  final String? companyDriverId;
  final String companyName;
  final String vehicleType; // "motorcycle" | "car" | "van" | "truck"
  final String vehicleBrand;
  final String vehicleModel;
  final int vehicleYear;
  final String licenseNumber;
  final List<DriverDocumentModel> documents;
  final String approvalStatus; // "pending" | "approved" | "rejected"
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? rejectionNote;
  final bool isAvailable;
  final double averageRating;
  final int totalRatings;
  final int totalDeliveries;
  final DateTime? lastLocationUpdatedAt;
  final BankInfoModel? bankInfo;

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
    this.bankInfo,
  });

  /// Quick approval helpers
  bool get isPending => approvalStatus == 'pending';
  bool get isApproved => approvalStatus == 'approved';
  bool get isRejected => approvalStatus == 'rejected';

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      driverType: json['driverType']?.toString() ?? '',
      companyId: json['companyId']?.toString(),
      companyDriverId: json['companyDriverId']?.toString(),
      companyName: json['companyName']?.toString() ?? '',
      vehicleType: json['vehicleType']?.toString() ?? '',
      vehicleBrand: json['vehicleBrand']?.toString() ?? '',
      vehicleModel: json['vehicleModel']?.toString() ?? '',
      vehicleYear: (json['vehicleYear'] as num?)?.toInt() ?? 0,
      licenseNumber: json['licenseNumber']?.toString() ?? '',
      documents: (json['documents'] as List<dynamic>? ?? [])
          .map((e) => DriverDocumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvalStatus: json['approvalStatus']?.toString() ?? 'pending',
      approvedBy: json['approvedBy']?.toString(),
      approvedAt: json['approvedAt'] != null
          ? DateTime.tryParse(json['approvedAt'].toString())
          : null,
      rejectionNote: json['rejectionNote']?.toString(),
      isAvailable: json['isAvailable'] == true,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
      totalDeliveries: (json['totalDeliveries'] as num?)?.toInt() ?? 0,
      lastLocationUpdatedAt: json['lastLocationUpdatedAt'] != null
          ? DateTime.tryParse(json['lastLocationUpdatedAt'].toString())
          : null,
      bankInfo: json['bankInfo'] != null
          ? BankInfoModel.fromJson(json['bankInfo'] as Map<String, dynamic>)
          : null,
    );
  }

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
    'documents': documents.map((d) => d.toJson()).toList(),
    'approvalStatus': approvalStatus,
    'approvedBy': approvedBy,
    'approvedAt': approvedAt?.toIso8601String(),
    'rejectionNote': rejectionNote,
    'isAvailable': isAvailable,
    'averageRating': averageRating,
    'totalRatings': totalRatings,
    'totalDeliveries': totalDeliveries,
    'lastLocationUpdatedAt': lastLocationUpdatedAt?.toIso8601String(),
    'bankInfo': bankInfo?.toJson(),
  };
}

// lib/data/models/bank_info_model.dart

class BankInfoModel {
  final String? bankName;
  final String? accountHolderName;
  final String? accountNumber;

  BankInfoModel({this.bankName, this.accountHolderName, this.accountNumber});

  factory BankInfoModel.fromJson(Map<String, dynamic> json) => BankInfoModel(
    bankName: json['bankName']?.toString(),
    accountHolderName: json['accountHolderName']?.toString(),
    accountNumber: json['accountNumber']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'bankName': bankName,
    'accountHolderName': accountHolderName,
    'accountNumber': accountNumber,
  };
}

// lib/data/models/driver_document_model.dart

class DriverDocumentModel {
  final String
  docType; // "driving_license" | "vehicle_registration" | "insurance"
  final String url;
  final DateTime? uploadedAt;

  DriverDocumentModel({
    required this.docType,
    required this.url,
    this.uploadedAt,
  });

  /// Full URL ready for Image.network()
  String get fullUrl => ApiUrl.buildImageUrl(url);

  /// Human-readable label
  String get label {
    switch (docType) {
      case 'driving_license':
        return 'Driving License';
      case 'vehicle_registration':
        return 'Vehicle Registration';
      case 'insurance':
        return 'Insurance';
      default:
        return docType;
    }
  }

  factory DriverDocumentModel.fromJson(Map<String, dynamic> json) {
    return DriverDocumentModel(
      docType: json['docType']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      uploadedAt: json['uploadedAt'] != null
          ? DateTime.tryParse(json['uploadedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'docType': docType,
    'url': url,
    'uploadedAt': uploadedAt?.toIso8601String(),
  };
}
