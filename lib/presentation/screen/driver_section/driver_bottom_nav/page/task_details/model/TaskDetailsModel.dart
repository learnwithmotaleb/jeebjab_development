// class TaskDetailsModel {
//   int? statusCode;
//   bool? success;
//   String? message;
//   Data? data;

//   TaskDetailsModel({this.statusCode, this.success, this.message, this.data});

//   TaskDetailsModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   User? user;
//   String? type;
//   List<String>? photos;
//   String? title;
//   String? description;
//   String? size;
//   Pickup? pickup;
//   Pickup? dropoff;
//   DateTimeSlot? dateTimeSlot;
//   int? price;
//   Null? campaignCode;
//   bool? acknowledged;
//   String? status;
//   String? assignedDriver;
//   PickupGeo? pickupGeo;
//   PickupGeo? dropoffGeo;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   List<Null>? wasteType;

//   Data(
//       {this.sId,
//         this.user,
//         this.type,
//         this.photos,
//         this.title,
//         this.description,
//         this.size,
//         this.pickup,
//         this.dropoff,
//         this.dateTimeSlot,
//         this.price,
//         this.campaignCode,
//         this.acknowledged,
//         this.status,
//         this.assignedDriver,
//         this.pickupGeo,
//         this.dropoffGeo,
//         this.createdAt,
//         this.updatedAt,
//         this.iV,
//         this.wasteType});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     type = json['type'];
//     photos = json['photos'].cast<String>();
//     title = json['title'];
//     description = json['description'];
//     size = json['size'];
//     pickup =
//     json['pickup'] != null ? new Pickup.fromJson(json['pickup']) : null;
//     dropoff =
//     json['dropoff'] != null ? new Pickup.fromJson(json['dropoff']) : null;
//     dateTimeSlot = json['dateTimeSlot'] != null
//         ? new DateTimeSlot.fromJson(json['dateTimeSlot'])
//         : null;
//     price = json['price'];
//     campaignCode = json['campaignCode'];
//     acknowledged = json['acknowledged'];
//     status = json['status'];
//     assignedDriver = json['assignedDriver'];
//     pickupGeo = json['pickupGeo'] != null
//         ? new PickupGeo.fromJson(json['pickupGeo'])
//         : null;
//     dropoffGeo = json['dropoffGeo'] != null
//         ? new PickupGeo.fromJson(json['dropoffGeo'])
//         : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     if (json['wasteType'] != null) {
//       wasteType = <Null>[];
//       json['wasteType'].forEach((v) {
//         wasteType!.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.user != null) {
//       data['user'] = this.user!.toJson();
//     }
//     data['type'] = this.type;
//     data['photos'] = this.photos;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['size'] = this.size;
//     if (this.pickup != null) {
//       data['pickup'] = this.pickup!.toJson();
//     }
//     if (this.dropoff != null) {
//       data['dropoff'] = this.dropoff!.toJson();
//     }
//     if (this.dateTimeSlot != null) {
//       data['dateTimeSlot'] = this.dateTimeSlot!.toJson();
//     }
//     data['price'] = this.price;
//     data['campaignCode'] = this.campaignCode;
//     data['acknowledged'] = this.acknowledged;
//     data['status'] = this.status;
//     data['assignedDriver'] = this.assignedDriver;
//     if (this.pickupGeo != null) {
//       data['pickupGeo'] = this.pickupGeo!.toJson();
//     }
//     if (this.dropoffGeo != null) {
//       data['dropoffGeo'] = this.dropoffGeo!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     if (this.wasteType != null) {
//       data['wasteType'] = this.wasteType!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class User {
//   String? sId;
//   String? name;
//   Null? phoneNumber;
//   Null? avatar;
//   int? ratingAsAdvertiser;

//   User(
//       {this.sId,
//         this.name,
//         this.phoneNumber,
//         this.avatar,
//         this.ratingAsAdvertiser});

//   User.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     phoneNumber = json['phoneNumber'];
//     avatar = json['avatar'];
//     ratingAsAdvertiser = json['ratingAsAdvertiser'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['phoneNumber'] = this.phoneNumber;
//     data['avatar'] = this.avatar;
//     data['ratingAsAdvertiser'] = this.ratingAsAdvertiser;
//     return data;
//   }
// }

// class Pickup {
//   Address? address;
//   Placement? placement;

//   Pickup({this.address, this.placement});

//   Pickup.fromJson(Map<String, dynamic> json) {
//     address =
//     json['address'] != null ? new Address.fromJson(json['address']) : null;
//     placement = json['placement'] != null
//         ? new Placement.fromJson(json['placement'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.address != null) {
//       data['address'] = this.address!.toJson();
//     }
//     if (this.placement != null) {
//       data['placement'] = this.placement!.toJson();
//     }
//     return data;
//   }
// }

// class Address {
//   String? text;
//   Coordinates? coordinates;

//   Address({this.text, this.coordinates});

//   Address.fromJson(Map<String, dynamic> json) {
//     text = json['text'];
//     coordinates = json['coordinates'] != null
//         ? new Coordinates.fromJson(json['coordinates'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['text'] = this.text;
//     if (this.coordinates != null) {
//       data['coordinates'] = this.coordinates!.toJson();
//     }
//     return data;
//   }
// }

// class Coordinates {
//   double? lat;
//   double? lng;

//   Coordinates({this.lat, this.lng});

//   Coordinates.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }

// class Placement {
//   String? placement;
//   bool? needToMeet;
//   bool? canHelpCarry;
//   String? floor;
//   String? doorCode;
//   bool? fitsInElevator;
//   String? otherInfo;

//   Placement(
//       {this.placement,
//         this.needToMeet,
//         this.canHelpCarry,
//         this.floor,
//         this.doorCode,
//         this.fitsInElevator,
//         this.otherInfo});

//   Placement.fromJson(Map<String, dynamic> json) {
//     placement = json['placement'];
//     needToMeet = json['needToMeet'];
//     canHelpCarry = json['canHelpCarry'];
//     floor = json['floor'];
//     doorCode = json['doorCode'];
//     fitsInElevator = json['fitsInElevator'];
//     otherInfo = json['otherInfo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['placement'] = this.placement;
//     data['needToMeet'] = this.needToMeet;
//     data['canHelpCarry'] = this.canHelpCarry;
//     data['floor'] = this.floor;
//     data['doorCode'] = this.doorCode;
//     data['fitsInElevator'] = this.fitsInElevator;
//     data['otherInfo'] = this.otherInfo;
//     return data;
//   }
// }

// class DateTimeSlot {
//   String? slotType;
//   String? scheduledDate;
//   String? scheduledTime;

//   DateTimeSlot({this.slotType, this.scheduledDate, this.scheduledTime});

//   DateTimeSlot.fromJson(Map<String, dynamic> json) {
//     slotType = json['slotType'];
//     scheduledDate = json['scheduledDate'];
//     scheduledTime = json['scheduledTime'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['slotType'] = this.slotType;
//     data['scheduledDate'] = this.scheduledDate;
//     data['scheduledTime'] = this.scheduledTime;
//     return data;
//   }
// }

// class PickupGeo {
//   String? type;
//   List<double>? coordinates;

//   PickupGeo({this.type, this.coordinates});

//   PickupGeo.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     coordinates = json['coordinates'].cast<double>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['coordinates'] = this.coordinates;
//     return data;
//   }
// }
