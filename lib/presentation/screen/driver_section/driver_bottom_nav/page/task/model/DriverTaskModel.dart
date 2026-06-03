import '../../../../../../../core/enums/task.dart';
import 'geo.dart';

class DriverTaskModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  DriverTaskModel({this.statusCode, this.success, this.message, this.data});

  factory DriverTaskModel.fromJson(Map<String, dynamic> json) {
    return DriverTaskModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'statusCode': statusCode,
    'success': success,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  Meta? meta;
  List<Task>? tasks;

  Data({this.meta, this.tasks});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      tasks: (json['tasks'] as List?)?.map((e) => Task.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'tasks': tasks?.map((e) => e.toJson()).toList(),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json['page'],
    limit: json['limit'],
    total: json['total'],
    totalPage: json['totalPage'],
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
  };
}

class Task {
  String? id;
  User? user;
  String? type;
  List<String>? photos;
  String? title;
  String? description;
  String? size;
  Pickup? pickup;
  Pickup? dropoff;
  DateTimeSlot? dateTimeSlot;
  int? price;
  String? campaignCode;
  bool? acknowledged;
  TaskStatus? status;
  String? assignedDriver;
  Geo? pickupGeo;
  Geo? dropoffGeo;
  String? createdAt;
  String? updatedAt;
  int? version;
  List<dynamic>? wasteType;

  Task({
    this.id,
    this.user,
    this.type,
    this.photos,
    this.title,
    this.description,
    this.size,
    this.pickup,
    this.dropoff,
    this.dateTimeSlot,
    this.price,
    this.campaignCode,
    this.acknowledged,
    this.status,
    this.assignedDriver,
    this.pickupGeo,
    this.dropoffGeo,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.wasteType,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      type: json['type'],
      photos: List<String>.from(json['photos'] ?? []),
      title: json['title'],
      description: json['description'],
      size: json['size'],
      pickup: json['pickup'] != null ? Pickup.fromJson(json['pickup']) : null,
      dropoff: json['dropoff'] != null
          ? Pickup.fromJson(json['dropoff'])
          : null,
      dateTimeSlot: json['dateTimeSlot'] != null
          ? DateTimeSlot.fromJson(json['dateTimeSlot'])
          : null,
      price: json['price'],
      campaignCode: json['campaignCode'],
      acknowledged: json['acknowledged'],
      status: taskStatusFromString(json['status']),
      assignedDriver: json['assignedDriver'],
      pickupGeo: json['pickupGeo'] != null
          ? Geo.fromJson(json['pickupGeo'])
          : null,
      dropoffGeo: json['dropoffGeo'] != null
          ? Geo.fromJson(json['dropoffGeo'])
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      version: json['__v'],
      wasteType: json['wasteType'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'user': user?.toJson(),
    'type': type,
    'photos': photos,
    'title': title,
    'description': description,
    'size': size,
    'pickup': pickup?.toJson(),
    'dropoff': dropoff?.toJson(),
    'dateTimeSlot': dateTimeSlot?.toJson(),
    'price': price,
    'campaignCode': campaignCode,
    'acknowledged': acknowledged,
    'status': status?.name,
    'assignedDriver': assignedDriver,
    'pickupGeo': pickupGeo?.toJson(),
    'dropoffGeo': dropoffGeo?.toJson(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': version,
    'wasteType': wasteType,
  };
}

class User {
  String? id;
  String? name;
  String? phoneNumber;
  String? avatar;

  User({this.id, this.name, this.phoneNumber, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'avatar': avatar,
  };
}

class Pickup {
  Address? address;
  Placement? placement;

  Pickup({this.address, this.placement});

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
    address: json['address'] != null ? Address.fromJson(json['address']) : null,
    placement: json['placement'] != null
        ? Placement.fromJson(json['placement'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'address': address?.toJson(),
    'placement': placement?.toJson(),
  };
}

class Address {
  String? text;
  Coordinates? coordinates;

  Address({this.text, this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    text: json['text'],
    coordinates: json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'coordinates': coordinates?.toJson(),
  };
}

class Coordinates {
  double? lat;
  double? lng;

  Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Placement {
  String? placement;
  bool? needToMeet;
  bool? canHelpCarry;
  String? floor;
  String? doorCode;
  bool? fitsInElevator;
  String? otherInfo;

  Placement({
    this.placement,
    this.needToMeet,
    this.canHelpCarry,
    this.floor,
    this.doorCode,
    this.fitsInElevator,
    this.otherInfo,
  });

  factory Placement.fromJson(Map<String, dynamic> json) => Placement(
    placement: json['placement'],
    needToMeet: json['needToMeet'],
    canHelpCarry: json['canHelpCarry'],
    floor: json['floor'],
    doorCode: json['doorCode'],
    fitsInElevator: json['fitsInElevator'],
    otherInfo: json['otherInfo'],
  );

  Map<String, dynamic> toJson() => {
    'placement': placement,
    'needToMeet': needToMeet,
    'canHelpCarry': canHelpCarry,
    'floor': floor,
    'doorCode': doorCode,
    'fitsInElevator': fitsInElevator,
    'otherInfo': otherInfo,
  };
}

class DateTimeSlot {
  String? slotType;
  String? scheduledDate;
  String? scheduledTime;

  DateTimeSlot({this.slotType, this.scheduledDate, this.scheduledTime});

  factory DateTimeSlot.fromJson(Map<String, dynamic> json) => DateTimeSlot(
    slotType: json['slotType'],
    scheduledDate: json['scheduledDate'],
    scheduledTime: json['scheduledTime'],
  );

  Map<String, dynamic> toJson() => {
    'slotType': slotType,
    'scheduledDate': scheduledDate,
    'scheduledTime': scheduledTime,
  };
}
