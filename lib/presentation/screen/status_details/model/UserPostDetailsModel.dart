/// statusCode : 200
/// success : true
/// message : "Post retrieved successfully"
/// data : {"_id":"6a30fc637224bd1f7faee2bf","user":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","phoneNumber":null,"avatar":null,"ratingAsAdvertiser":0},"type":"move","wasteType":[],"photos":["uploads\\post_image\\1781595235066-scaled_1001206006.jpg","uploads\\post_image\\1781595235071-scaled_1001206004.jpg","uploads\\post_image\\1781595235139-scaled_1001206003.jpg"],"title":"brazil","description":"the argentina is best to brazil","size":"medium","pickup":{"address":{"text":"Abu Dhabi - 23052","coordinates":{"lat":25.1972,"lng":55.2744}},"placement":{"placement":"inside","needToMeet":true,"canHelpCarry":false,"floor":"25d","doorCode":"30d","fitsInElevator":false,"otherInfo":""}},"dropoff":{"address":{"text":"Abu Dhabi - 23052","coordinates":{"lat":24.4539,"lng":54.3773}},"placement":{"placement":"inside","needToMeet":false,"canHelpCarry":false,"floor":"25d","doorCode":"5dd","fitsInElevator":false,"otherInfo":""}},"dateTimeSlot":{"slotType":"priority","scheduledDate":null,"scheduledTime":null},"price":1800,"campaignCode":null,"acknowledged":true,"status":"pending","assignedDriver":null,"pickupGeo":{"type":"Point","coordinates":[55.2744,25.1972]},"dropoffGeo":{"type":"Point","coordinates":[54.3773,24.4539]},"completionProof":{"location":{"lat":null,"lng":null},"photo":null,"submittedAt":null},"createdAt":"2026-06-16T07:33:55.158Z","updatedAt":"2026-06-16T07:33:55.158Z","__v":0,"canRequestJob":false,"myRequest":null,"jobRequests":[{"requestId":"6a30fcb37224bd1f7faee2eb","status":"pending","message":"","requestedAt":"2026-06-16T07:35:15.740Z","driver":{"_id":"6a07cab6d26aa947309412d3","name":"soniaai","avatar":null,"phoneNumber":null,"rating":0,"totalRatings":0,"vehicleInfo":null}}]}

class UserPostDetailsModel {
  UserPostDetailsModel({
    num? statusCode,
    bool? success,
    String? message,
    Data? data,
  }) {
    _statusCode = statusCode;
    _success = success;
    _message = message;
    _data = data;
  }

  UserPostDetailsModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  bool? _success;
  String? _message;
  Data? _data;
  UserPostDetailsModel copyWith({
    num? statusCode,
    bool? success,
    String? message,
    Data? data,
  }) => UserPostDetailsModel(
    statusCode: statusCode ?? _statusCode,
    success: success ?? _success,
    message: message ?? _message,
    data: data ?? _data,
  );
  num? get statusCode => _statusCode;
  bool? get success => _success;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// _id : "6a30fc637224bd1f7faee2bf"
/// user : {"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","phoneNumber":null,"avatar":null,"ratingAsAdvertiser":0}
/// type : "move"
/// wasteType : []
/// photos : ["uploads\\post_image\\1781595235066-scaled_1001206006.jpg","uploads\\post_image\\1781595235071-scaled_1001206004.jpg","uploads\\post_image\\1781595235139-scaled_1001206003.jpg"]
/// title : "brazil"
/// description : "the argentina is best to brazil"
/// size : "medium"
/// pickup : {"address":{"text":"Abu Dhabi - 23052","coordinates":{"lat":25.1972,"lng":55.2744}},"placement":{"placement":"inside","needToMeet":true,"canHelpCarry":false,"floor":"25d","doorCode":"30d","fitsInElevator":false,"otherInfo":""}}
/// dropoff : {"address":{"text":"Abu Dhabi - 23052","coordinates":{"lat":24.4539,"lng":54.3773}},"placement":{"placement":"inside","needToMeet":false,"canHelpCarry":false,"floor":"25d","doorCode":"5dd","fitsInElevator":false,"otherInfo":""}}
/// dateTimeSlot : {"slotType":"priority","scheduledDate":null,"scheduledTime":null}
/// price : 1800
/// campaignCode : null
/// acknowledged : true
/// status : "pending"
/// assignedDriver : null
/// pickupGeo : {"type":"Point","coordinates":[55.2744,25.1972]}
/// dropoffGeo : {"type":"Point","coordinates":[54.3773,24.4539]}
/// completionProof : {"location":{"lat":null,"lng":null},"photo":null,"submittedAt":null}
/// createdAt : "2026-06-16T07:33:55.158Z"
/// updatedAt : "2026-06-16T07:33:55.158Z"
/// __v : 0
/// canRequestJob : false
/// myRequest : null
/// jobRequests : [{"requestId":"6a30fcb37224bd1f7faee2eb","status":"pending","message":"","requestedAt":"2026-06-16T07:35:15.740Z","driver":{"_id":"6a07cab6d26aa947309412d3","name":"soniaai","avatar":null,"phoneNumber":null,"rating":0,"totalRatings":0,"vehicleInfo":null}}]

class Data {
  Data({
    String? id,
    User? user,
    String? type,
    List<dynamic>? wasteType,
    List<String>? photos,
    String? title,
    String? description,
    String? size,
    Pickup? pickup,
    Dropoff? dropoff,
    DateTimeSlot? dateTimeSlot,
    num? price,
    dynamic campaignCode,
    bool? acknowledged,
    String? status,
    dynamic assignedDriver,
    PickupGeo? pickupGeo,
    DropoffGeo? dropoffGeo,
    CompletionProof? completionProof,
    String? createdAt,
    String? updatedAt,
    num? v,
    bool? canRequestJob,
    dynamic myRequest,
    List<JobRequests>? jobRequests,
  }) {
    _id = id;
    _user = user;
    _type = type;
    _wasteType = wasteType;
    _photos = photos;
    _title = title;
    _description = description;
    _size = size;
    _pickup = pickup;
    _dropoff = dropoff;
    _dateTimeSlot = dateTimeSlot;
    _price = price;
    _campaignCode = campaignCode;
    _acknowledged = acknowledged;
    _status = status;
    _assignedDriver = assignedDriver;
    _pickupGeo = pickupGeo;
    _dropoffGeo = dropoffGeo;
    _completionProof = completionProof;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _canRequestJob = canRequestJob;
    _myRequest = myRequest;
    _jobRequests = jobRequests;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _type = json['type'];
    if (json['wasteType'] != null) {
      _wasteType = [];
      json['wasteType'].forEach((v) {
        _wasteType?.add(v);
      });
    }
    _photos = json['photos'] != null ? json['photos'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _size = json['size'];
    _pickup = json['pickup'] != null ? Pickup.fromJson(json['pickup']) : null;
    _dropoff = json['dropoff'] != null
        ? Dropoff.fromJson(json['dropoff'])
        : null;
    _dateTimeSlot = json['dateTimeSlot'] != null
        ? DateTimeSlot.fromJson(json['dateTimeSlot'])
        : null;
    _price = json['price'];
    _campaignCode = json['campaignCode'];
    _acknowledged = json['acknowledged'];
    _status = json['status'];
    _assignedDriver = json['assignedDriver'];
    _pickupGeo = json['pickupGeo'] != null
        ? PickupGeo.fromJson(json['pickupGeo'])
        : null;
    _dropoffGeo = json['dropoffGeo'] != null
        ? DropoffGeo.fromJson(json['dropoffGeo'])
        : null;
    _completionProof = json['completionProof'] != null
        ? CompletionProof.fromJson(json['completionProof'])
        : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _canRequestJob = json['canRequestJob'];
    _myRequest = json['myRequest'];
    if (json['jobRequests'] != null) {
      _jobRequests = [];
      json['jobRequests'].forEach((v) {
        _jobRequests?.add(JobRequests.fromJson(v));
      });
    }
  }
  String? _id;
  User? _user;
  String? _type;
  List<dynamic>? _wasteType;
  List<String>? _photos;
  String? _title;
  String? _description;
  String? _size;
  Pickup? _pickup;
  Dropoff? _dropoff;
  DateTimeSlot? _dateTimeSlot;
  num? _price;
  dynamic _campaignCode;
  bool? _acknowledged;
  String? _status;
  dynamic _assignedDriver;
  PickupGeo? _pickupGeo;
  DropoffGeo? _dropoffGeo;
  CompletionProof? _completionProof;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  bool? _canRequestJob;
  dynamic _myRequest;
  List<JobRequests>? _jobRequests;
  Data copyWith({
    String? id,
    User? user,
    String? type,
    List<dynamic>? wasteType,
    List<String>? photos,
    String? title,
    String? description,
    String? size,
    Pickup? pickup,
    Dropoff? dropoff,
    DateTimeSlot? dateTimeSlot,
    num? price,
    dynamic campaignCode,
    bool? acknowledged,
    String? status,
    dynamic assignedDriver,
    PickupGeo? pickupGeo,
    DropoffGeo? dropoffGeo,
    CompletionProof? completionProof,
    String? createdAt,
    String? updatedAt,
    num? v,
    bool? canRequestJob,
    dynamic myRequest,
    List<JobRequests>? jobRequests,
  }) => Data(
    id: id ?? _id,
    user: user ?? _user,
    type: type ?? _type,
    wasteType: wasteType ?? _wasteType,
    photos: photos ?? _photos,
    title: title ?? _title,
    description: description ?? _description,
    size: size ?? _size,
    pickup: pickup ?? _pickup,
    dropoff: dropoff ?? _dropoff,
    dateTimeSlot: dateTimeSlot ?? _dateTimeSlot,
    price: price ?? _price,
    campaignCode: campaignCode ?? _campaignCode,
    acknowledged: acknowledged ?? _acknowledged,
    status: status ?? _status,
    assignedDriver: assignedDriver ?? _assignedDriver,
    pickupGeo: pickupGeo ?? _pickupGeo,
    dropoffGeo: dropoffGeo ?? _dropoffGeo,
    completionProof: completionProof ?? _completionProof,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
    canRequestJob: canRequestJob ?? _canRequestJob,
    myRequest: myRequest ?? _myRequest,
    jobRequests: jobRequests ?? _jobRequests,
  );
  String? get id => _id;
  User? get user => _user;
  String? get type => _type;
  List<dynamic>? get wasteType => _wasteType;
  List<String>? get photos => _photos;
  String? get title => _title;
  String? get description => _description;
  String? get size => _size;
  Pickup? get pickup => _pickup;
  Dropoff? get dropoff => _dropoff;
  DateTimeSlot? get dateTimeSlot => _dateTimeSlot;
  num? get price => _price;
  dynamic get campaignCode => _campaignCode;
  bool? get acknowledged => _acknowledged;
  String? get status => _status;
  dynamic get assignedDriver => _assignedDriver;
  PickupGeo? get pickupGeo => _pickupGeo;
  DropoffGeo? get dropoffGeo => _dropoffGeo;
  CompletionProof? get completionProof => _completionProof;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  bool? get canRequestJob => _canRequestJob;
  dynamic get myRequest => _myRequest;
  List<JobRequests>? get jobRequests => _jobRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['type'] = _type;
    if (_wasteType != null) {
      map['wasteType'] = _wasteType;
    }
    map['photos'] = _photos;
    map['title'] = _title;
    map['description'] = _description;
    map['size'] = _size;
    if (_pickup != null) {
      map['pickup'] = _pickup?.toJson();
    }
    if (_dropoff != null) {
      map['dropoff'] = _dropoff?.toJson();
    }
    if (_dateTimeSlot != null) {
      map['dateTimeSlot'] = _dateTimeSlot?.toJson();
    }
    map['price'] = _price;
    map['campaignCode'] = _campaignCode;
    map['acknowledged'] = _acknowledged;
    map['status'] = _status;
    map['assignedDriver'] = _assignedDriver;
    if (_pickupGeo != null) {
      map['pickupGeo'] = _pickupGeo?.toJson();
    }
    if (_dropoffGeo != null) {
      map['dropoffGeo'] = _dropoffGeo?.toJson();
    }
    if (_completionProof != null) {
      map['completionProof'] = _completionProof?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['canRequestJob'] = _canRequestJob;
    map['myRequest'] = _myRequest;
    if (_jobRequests != null) {
      map['jobRequests'] = _jobRequests?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// requestId : "6a30fcb37224bd1f7faee2eb"
/// status : "pending"
/// message : ""
/// requestedAt : "2026-06-16T07:35:15.740Z"
/// driver : {"_id":"6a07cab6d26aa947309412d3","name":"soniaai","avatar":null,"phoneNumber":null,"rating":0,"totalRatings":0,"vehicleInfo":null}

class JobRequests {
  JobRequests({
    String? requestId,
    String? status,
    String? message,
    String? requestedAt,
    Driver? driver,
  }) {
    _requestId = requestId;
    _status = status;
    _message = message;
    _requestedAt = requestedAt;
    _driver = driver;
  }

  JobRequests.fromJson(dynamic json) {
    _requestId = json['requestId'];
    _status = json['status'];
    _message = json['message'];
    _requestedAt = json['requestedAt'];
    _driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }
  String? _requestId;
  String? _status;
  String? _message;
  String? _requestedAt;
  Driver? _driver;
  JobRequests copyWith({
    String? requestId,
    String? status,
    String? message,
    String? requestedAt,
    Driver? driver,
  }) => JobRequests(
    requestId: requestId ?? _requestId,
    status: status ?? _status,
    message: message ?? _message,
    requestedAt: requestedAt ?? _requestedAt,
    driver: driver ?? _driver,
  );
  String? get requestId => _requestId;
  String? get status => _status;
  String? get message => _message;
  String? get requestedAt => _requestedAt;
  Driver? get driver => _driver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['requestId'] = _requestId;
    map['status'] = _status;
    map['message'] = _message;
    map['requestedAt'] = _requestedAt;
    if (_driver != null) {
      map['driver'] = _driver?.toJson();
    }
    return map;
  }
}

/// _id : "6a07cab6d26aa947309412d3"
/// name : "soniaai"
/// avatar : null
/// phoneNumber : null
/// rating : 0
/// totalRatings : 0
/// vehicleInfo : null

class Driver {
  Driver({
    String? id,
    String? name,
    dynamic avatar,
    dynamic phoneNumber,
    num? rating,
    num? totalRatings,
    dynamic vehicleInfo,
  }) {
    _id = id;
    _name = name;
    _avatar = avatar;
    _phoneNumber = phoneNumber;
    _rating = rating;
    _totalRatings = totalRatings;
    _vehicleInfo = vehicleInfo;
  }

  Driver.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _avatar = json['avatar'];
    _phoneNumber = json['phoneNumber'];
    _rating = json['rating'];
    _totalRatings = json['totalRatings'];
    _vehicleInfo = json['vehicleInfo'];
  }
  String? _id;
  String? _name;
  dynamic _avatar;
  dynamic _phoneNumber;
  num? _rating;
  num? _totalRatings;
  dynamic _vehicleInfo;
  Driver copyWith({
    String? id,
    String? name,
    dynamic avatar,
    dynamic phoneNumber,
    num? rating,
    num? totalRatings,
    dynamic vehicleInfo,
  }) => Driver(
    id: id ?? _id,
    name: name ?? _name,
    avatar: avatar ?? _avatar,
    phoneNumber: phoneNumber ?? _phoneNumber,
    rating: rating ?? _rating,
    totalRatings: totalRatings ?? _totalRatings,
    vehicleInfo: vehicleInfo ?? _vehicleInfo,
  );
  String? get id => _id;
  String? get name => _name;
  dynamic get avatar => _avatar;
  dynamic get phoneNumber => _phoneNumber;
  num? get rating => _rating;
  num? get totalRatings => _totalRatings;
  dynamic get vehicleInfo => _vehicleInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['phoneNumber'] = _phoneNumber;
    map['rating'] = _rating;
    map['totalRatings'] = _totalRatings;
    map['vehicleInfo'] = _vehicleInfo;
    return map;
  }
}

/// location : {"lat":null,"lng":null}
/// photo : null
/// submittedAt : null

class CompletionProof {
  CompletionProof({Location? location, dynamic photo, dynamic submittedAt}) {
    _location = location;
    _photo = photo;
    _submittedAt = submittedAt;
  }

  CompletionProof.fromJson(dynamic json) {
    _location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    _photo = json['photo'];
    _submittedAt = json['submittedAt'];
  }
  Location? _location;
  dynamic _photo;
  dynamic _submittedAt;
  CompletionProof copyWith({
    Location? location,
    dynamic photo,
    dynamic submittedAt,
  }) => CompletionProof(
    location: location ?? _location,
    photo: photo ?? _photo,
    submittedAt: submittedAt ?? _submittedAt,
  );
  Location? get location => _location;
  dynamic get photo => _photo;
  dynamic get submittedAt => _submittedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['photo'] = _photo;
    map['submittedAt'] = _submittedAt;
    return map;
  }
}

/// lat : null
/// lng : null

class Location {
  Location({dynamic lat, dynamic lng}) {
    _lat = lat;
    _lng = lng;
  }

  Location.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  dynamic _lat;
  dynamic _lng;
  Location copyWith({dynamic lat, dynamic lng}) =>
      Location(lat: lat ?? _lat, lng: lng ?? _lng);
  dynamic get lat => _lat;
  dynamic get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}

/// type : "Point"
/// coordinates : [54.3773,24.4539]

class DropoffGeo {
  DropoffGeo({String? type, List<num>? coordinates}) {
    _type = type;
    _coordinates = coordinates;
  }

  DropoffGeo.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<num>()
        : [];
  }
  String? _type;
  List<num>? _coordinates;
  DropoffGeo copyWith({String? type, List<num>? coordinates}) =>
      DropoffGeo(type: type ?? _type, coordinates: coordinates ?? _coordinates);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }
}

/// type : "Point"
/// coordinates : [55.2744,25.1972]

class PickupGeo {
  PickupGeo({String? type, List<num>? coordinates}) {
    _type = type;
    _coordinates = coordinates;
  }

  PickupGeo.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null
        ? json['coordinates'].cast<num>()
        : [];
  }
  String? _type;
  List<num>? _coordinates;
  PickupGeo copyWith({String? type, List<num>? coordinates}) =>
      PickupGeo(type: type ?? _type, coordinates: coordinates ?? _coordinates);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }
}

/// slotType : "priority"
/// scheduledDate : null
/// scheduledTime : null

class DateTimeSlot {
  DateTimeSlot({
    String? slotType,
    dynamic scheduledDate,
    dynamic scheduledTime,
  }) {
    _slotType = slotType;
    _scheduledDate = scheduledDate;
    _scheduledTime = scheduledTime;
  }

  DateTimeSlot.fromJson(dynamic json) {
    _slotType = json['slotType'];
    _scheduledDate = json['scheduledDate'];
    _scheduledTime = json['scheduledTime'];
  }
  String? _slotType;
  dynamic _scheduledDate;
  dynamic _scheduledTime;
  DateTimeSlot copyWith({
    String? slotType,
    dynamic scheduledDate,
    dynamic scheduledTime,
  }) => DateTimeSlot(
    slotType: slotType ?? _slotType,
    scheduledDate: scheduledDate ?? _scheduledDate,
    scheduledTime: scheduledTime ?? _scheduledTime,
  );
  String? get slotType => _slotType;
  dynamic get scheduledDate => _scheduledDate;
  dynamic get scheduledTime => _scheduledTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slotType'] = _slotType;
    map['scheduledDate'] = _scheduledDate;
    map['scheduledTime'] = _scheduledTime;
    return map;
  }
}

/// address : {"text":"Abu Dhabi - 23052","coordinates":{"lat":24.4539,"lng":54.3773}}
/// placement : {"placement":"inside","needToMeet":false,"canHelpCarry":false,"floor":"25d","doorCode":"5dd","fitsInElevator":false,"otherInfo":""}

class Dropoff {
  Dropoff({Address? address, Placement? placement}) {
    _address = address;
    _placement = placement;
  }

  Dropoff.fromJson(dynamic json) {
    _address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    _placement = json['placement'] != null
        ? Placement.fromJson(json['placement'])
        : null;
  }
  Address? _address;
  Placement? _placement;
  Dropoff copyWith({Address? address, Placement? placement}) =>
      Dropoff(address: address ?? _address, placement: placement ?? _placement);
  Address? get address => _address;
  Placement? get placement => _placement;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_placement != null) {
      map['placement'] = _placement?.toJson();
    }
    return map;
  }
}

/// placement : "inside"
/// needToMeet : false
/// canHelpCarry : false
/// floor : "25d"
/// doorCode : "5dd"
/// fitsInElevator : false
/// otherInfo : ""

class Placement {
  Placement({
    String? placement,
    bool? needToMeet,
    bool? canHelpCarry,
    String? floor,
    String? doorCode,
    bool? fitsInElevator,
    String? otherInfo,
  }) {
    _placement = placement;
    _needToMeet = needToMeet;
    _canHelpCarry = canHelpCarry;
    _floor = floor;
    _doorCode = doorCode;
    _fitsInElevator = fitsInElevator;
    _otherInfo = otherInfo;
  }

  Placement.fromJson(dynamic json) {
    _placement = json['placement'];
    _needToMeet = json['needToMeet'];
    _canHelpCarry = json['canHelpCarry'];
    _floor = json['floor'];
    _doorCode = json['doorCode'];
    _fitsInElevator = json['fitsInElevator'];
    _otherInfo = json['otherInfo'];
  }
  String? _placement;
  bool? _needToMeet;
  bool? _canHelpCarry;
  String? _floor;
  String? _doorCode;
  bool? _fitsInElevator;
  String? _otherInfo;
  Placement copyWith({
    String? placement,
    bool? needToMeet,
    bool? canHelpCarry,
    String? floor,
    String? doorCode,
    bool? fitsInElevator,
    String? otherInfo,
  }) => Placement(
    placement: placement ?? _placement,
    needToMeet: needToMeet ?? _needToMeet,
    canHelpCarry: canHelpCarry ?? _canHelpCarry,
    floor: floor ?? _floor,
    doorCode: doorCode ?? _doorCode,
    fitsInElevator: fitsInElevator ?? _fitsInElevator,
    otherInfo: otherInfo ?? _otherInfo,
  );
  String? get placement => _placement;
  bool? get needToMeet => _needToMeet;
  bool? get canHelpCarry => _canHelpCarry;
  String? get floor => _floor;
  String? get doorCode => _doorCode;
  bool? get fitsInElevator => _fitsInElevator;
  String? get otherInfo => _otherInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['placement'] = _placement;
    map['needToMeet'] = _needToMeet;
    map['canHelpCarry'] = _canHelpCarry;
    map['floor'] = _floor;
    map['doorCode'] = _doorCode;
    map['fitsInElevator'] = _fitsInElevator;
    map['otherInfo'] = _otherInfo;
    return map;
  }
}

/// text : "Abu Dhabi - 23052"
/// coordinates : {"lat":24.4539,"lng":54.3773}

class Address {
  Address({String? text, Coordinates? coordinates}) {
    _text = text;
    _coordinates = coordinates;
  }

  Address.fromJson(dynamic json) {
    _text = json['text'];
    _coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
  }
  String? _text;
  Coordinates? _coordinates;
  Address copyWith({String? text, Coordinates? coordinates}) =>
      Address(text: text ?? _text, coordinates: coordinates ?? _coordinates);
  String? get text => _text;
  Coordinates? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.toJson();
    }
    return map;
  }
}

/// lat : 24.4539
/// lng : 54.3773

class Coordinates {
  Coordinates({num? lat, num? lng}) {
    _lat = lat;
    _lng = lng;
  }

  Coordinates.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _lat;
  num? _lng;
  Coordinates copyWith({num? lat, num? lng}) =>
      Coordinates(lat: lat ?? _lat, lng: lng ?? _lng);
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}

/// address : {"text":"Abu Dhabi - 23052","coordinates":{"lat":25.1972,"lng":55.2744}}
/// placement : {"placement":"inside","needToMeet":true,"canHelpCarry":false,"floor":"25d","doorCode":"30d","fitsInElevator":false,"otherInfo":""}

class Pickup {
  Pickup({Address? address, Placement? placement}) {
    _address = address;
    _placement = placement;
  }

  Pickup.fromJson(dynamic json) {
    _address = json['address'] != null
        ? Address.fromJson(json['address'])
        : null;
    _placement = json['placement'] != null
        ? Placement.fromJson(json['placement'])
        : null;
  }
  Address? _address;
  Placement? _placement;
  Pickup copyWith({Address? address, Placement? placement}) =>
      Pickup(address: address ?? _address, placement: placement ?? _placement);
  Address? get address => _address;
  Placement? get placement => _placement;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    if (_placement != null) {
      map['placement'] = _placement?.toJson();
    }
    return map;
  }
}

/// _id : "6a1fe7169cb145fcff357887"
/// name : "jeebjabuser"
/// phoneNumber : null
/// avatar : null
/// ratingAsAdvertiser : 0

class User {
  User({
    String? id,
    String? name,
    dynamic phoneNumber,
    dynamic avatar,
    num? ratingAsAdvertiser,
  }) {
    _id = id;
    _name = name;
    _phoneNumber = phoneNumber;
    _avatar = avatar;
    _ratingAsAdvertiser = ratingAsAdvertiser;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _phoneNumber = json['phoneNumber'];
    _avatar = json['avatar'];
    _ratingAsAdvertiser = json['ratingAsAdvertiser'];
  }
  String? _id;
  String? _name;
  dynamic _phoneNumber;
  dynamic _avatar;
  num? _ratingAsAdvertiser;
  User copyWith({
    String? id,
    String? name,
    dynamic phoneNumber,
    dynamic avatar,
    num? ratingAsAdvertiser,
  }) => User(
    id: id ?? _id,
    name: name ?? _name,
    phoneNumber: phoneNumber ?? _phoneNumber,
    avatar: avatar ?? _avatar,
    ratingAsAdvertiser: ratingAsAdvertiser ?? _ratingAsAdvertiser,
  );
  String? get id => _id;
  String? get name => _name;
  dynamic get phoneNumber => _phoneNumber;
  dynamic get avatar => _avatar;
  num? get ratingAsAdvertiser => _ratingAsAdvertiser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['phoneNumber'] = _phoneNumber;
    map['avatar'] = _avatar;
    map['ratingAsAdvertiser'] = _ratingAsAdvertiser;
    return map;
  }
}
