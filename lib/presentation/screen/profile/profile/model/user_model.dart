// lib/data/models/user_model.dart

class UserModel {
  final String id;
  final String authId;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? avatar;
  final bool isPhoneVerified;
  final String? defaultAddress;
  final DriverProfileModel? driverProfile;
  final bool isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.authId,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.avatar,
    required this.isPhoneVerified,
    this.defaultAddress,
    this.driverProfile,
    required this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  /// Full avatar URL ready for Image.network()
  String? get avatarUrl =>
      avatar != null ? 'http://$avatar' : null;

  bool get isDriver => driverProfile != null;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // ── unwrap envelope if needed ──────────────────────────
    final d = json['data'] != null
        ? json['data'] as Map<String, dynamic>
        : json;

    return UserModel(
      id:              d['_id']?.toString()          ?? '',
      authId:          d['authId']?.toString()       ?? '',
      name:            d['name']?.toString()         ?? '',
      email:           d['email']?.toString()        ?? '',
      phoneNumber:     d['phoneNumber']?.toString(),
      avatar:          d['avatar']?.toString(),
      isPhoneVerified: d['isPhoneVerified'] == true,
      defaultAddress:  d['defaultAddress']?.toString(),
      driverProfile:   d['driverProfile'] != null
          ? DriverProfileModel.fromJson(
          d['driverProfile'] as Map<String, dynamic>)
          : null,
      isDeleted:       d['isDeleted'] == true,
      createdAt:       d['createdAt'] != null
          ? DateTime.tryParse(d['createdAt'].toString())
          : null,
      updatedAt:       d['updatedAt'] != null
          ? DateTime.tryParse(d['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id':             id,
    'authId':          authId,
    'name':            name,
    'email':           email,
    'phoneNumber':     phoneNumber,
    'avatar':          avatar,
    'isPhoneVerified': isPhoneVerified,
    'defaultAddress':  defaultAddress,
    'driverProfile':   driverProfile?.toJson(),
    'isDeleted':       isDeleted,
    'createdAt':       createdAt?.toIso8601String(),
    'updatedAt':       updatedAt?.toIso8601String(),
  };

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? avatar,
    String? defaultAddress,
    DriverProfileModel? driverProfile,
  }) {
    return UserModel(
      id:              id,
      authId:          authId,
      name:            name            ?? this.name,
      email:           email,
      phoneNumber:     phoneNumber     ?? this.phoneNumber,
      avatar:          avatar          ?? this.avatar,
      isPhoneVerified: isPhoneVerified,
      defaultAddress:  defaultAddress  ?? this.defaultAddress,
      driverProfile:   driverProfile   ?? this.driverProfile,
      isDeleted:       isDeleted,
      createdAt:       createdAt,
      updatedAt:       updatedAt,
    );
  }
}

// lib/data/models/driver_profile_model.dart

class DriverProfileModel {
  final String driverType;        // "independent"
  final String? companyId;
  final String? companyDriverId;
  final String companyName;
  final String vehicleType;       // "motorcycle"
  final String vehicleBrand;
  final String vehicleModel;
  final int vehicleYear;
  final String licenseNumber;
  final List<DriverDocumentModel> documents;
  final String approvalStatus;    // "pending" | "approved" | "rejected"
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? rejectionNote;
  final bool isAvailable;
  final double averageRating;
  final int totalRatings;
  final int totalDeliveries;
  final DateTime? lastLocationUpdatedAt;

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

  /// Quick approval helpers
  bool get isPending  => approvalStatus == 'pending';
  bool get isApproved => approvalStatus == 'approved';
  bool get isRejected => approvalStatus == 'rejected';

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      driverType:             json['driverType']?.toString()       ?? '',
      companyId:              json['companyId']?.toString(),
      companyDriverId:        json['companyDriverId']?.toString(),
      companyName:            json['companyName']?.toString()      ?? '',
      vehicleType:            json['vehicleType']?.toString()      ?? '',
      vehicleBrand:           json['vehicleBrand']?.toString()     ?? '',
      vehicleModel:           json['vehicleModel']?.toString()     ?? '',
      vehicleYear:            (json['vehicleYear'] as num?)?.toInt() ?? 0,
      licenseNumber:          json['licenseNumber']?.toString()    ?? '',
      documents:              (json['documents'] as List<dynamic>? ?? [])
          .map((e) => DriverDocumentModel.fromJson(
          e as Map<String, dynamic>))
          .toList(),
      approvalStatus:         json['approvalStatus']?.toString()   ?? 'pending',
      approvedBy:             json['approvedBy']?.toString(),
      approvedAt:             json['approvedAt'] != null
          ? DateTime.tryParse(json['approvedAt'].toString())
          : null,
      rejectionNote:          json['rejectionNote']?.toString(),
      isAvailable:            json['isAvailable'] == true,
      averageRating:          (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings:           (json['totalRatings'] as num?)?.toInt()     ?? 0,
      totalDeliveries:        (json['totalDeliveries'] as num?)?.toInt()  ?? 0,
      lastLocationUpdatedAt:  json['lastLocationUpdatedAt'] != null
          ? DateTime.tryParse(
          json['lastLocationUpdatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'driverType':            driverType,
    'companyId':             companyId,
    'companyDriverId':       companyDriverId,
    'companyName':           companyName,
    'vehicleType':           vehicleType,
    'vehicleBrand':          vehicleBrand,
    'vehicleModel':          vehicleModel,
    'vehicleYear':           vehicleYear,
    'licenseNumber':         licenseNumber,
    'documents':             documents.map((d) => d.toJson()).toList(),
    'approvalStatus':        approvalStatus,
    'approvedBy':            approvedBy,
    'approvedAt':            approvedAt?.toIso8601String(),
    'rejectionNote':         rejectionNote,
    'isAvailable':           isAvailable,
    'averageRating':         averageRating,
    'totalRatings':          totalRatings,
    'totalDeliveries':       totalDeliveries,
    'lastLocationUpdatedAt': lastLocationUpdatedAt?.toIso8601String(),
  };
}

// lib/data/models/driver_document_model.dart

class DriverDocumentModel {
  final String docType;   // "driving_license" | "vehicle_registration" | "insurance"
  final String url;
  final DateTime? uploadedAt;

  DriverDocumentModel({
    required this.docType,
    required this.url,
    this.uploadedAt,
  });

  /// Full URL ready for Image.network()
  String get fullUrl => 'http://$url';

  /// Human-readable label
  String get label {
    switch (docType) {
      case 'driving_license':      return 'Driving License';
      case 'vehicle_registration': return 'Vehicle Registration';
      case 'insurance':            return 'Insurance';
      default:                     return docType;
    }
  }

  factory DriverDocumentModel.fromJson(Map<String, dynamic> json) {
    return DriverDocumentModel(
      docType:    json['docType']?.toString()  ?? '',
      url:        json['url']?.toString()      ?? '',
      uploadedAt: json['uploadedAt'] != null
          ? DateTime.tryParse(json['uploadedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'docType':    docType,
    'url':        url,
    'uploadedAt': uploadedAt?.toIso8601String(),
  };
}