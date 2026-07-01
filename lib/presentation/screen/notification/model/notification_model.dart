/// statusCode : 200
/// success : true
/// message : "Notifications fetched"
/// data : {"meta":{"page":1,"limit":20,"total":3,"totalPage":1,"unreadCount":3},"notifications":[{"_id":"6a33996b613b4e20e3c46f88","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-18T07:08:27.164Z","updatedAt":"2026-06-18T07:08:27.164Z","__v":0},{"_id":"6a3389eed0dad3cd60b47f26","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-18T06:02:22.884Z","updatedAt":"2026-06-18T06:02:22.884Z","__v":0},{"_id":"6a3262d5ae129d642a6695d6","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-17T09:03:17.605Z","updatedAt":"2026-06-17T09:03:17.605Z","__v":0}]}

class NotificationsModel {
  NotificationsModel({
    num? statusCode,
    bool? success,
    String? message,
    Data? data,}){
    _statusCode = statusCode;
    _success = success;
    _message = message;
    _data = data;
  }

  NotificationsModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  bool? _success;
  String? _message;
  Data? _data;
  NotificationsModel copyWith({  num? statusCode,
    bool? success,
    String? message,
    Data? data,
  }) => NotificationsModel(  statusCode: statusCode ?? _statusCode,
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

/// meta : {"page":1,"limit":20,"total":3,"totalPage":1,"unreadCount":3}
/// notifications : [{"_id":"6a33996b613b4e20e3c46f88","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-18T07:08:27.164Z","updatedAt":"2026-06-18T07:08:27.164Z","__v":0},{"_id":"6a3389eed0dad3cd60b47f26","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-18T06:02:22.884Z","updatedAt":"2026-06-18T06:02:22.884Z","__v":0},{"_id":"6a3262d5ae129d642a6695d6","toId":"6a1fe7169cb145fcff357887","title":"New message","message":"Sent a undefined","isRead":false,"createdAt":"2026-06-17T09:03:17.605Z","updatedAt":"2026-06-17T09:03:17.605Z","__v":0}]

class Data {
  Data({
    Meta? meta,
    List<Notifications>? notifications,}){
    _meta = meta;
    _notifications = notifications;
  }

  Data.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<Notifications>? _notifications;
  Data copyWith({  Meta? meta,
    List<Notifications>? notifications,
  }) => Data(  meta: meta ?? _meta,
    notifications: notifications ?? _notifications,
  );
  Meta? get meta => _meta;
  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6a33996b613b4e20e3c46f88"
/// toId : "6a1fe7169cb145fcff357887"
/// title : "New message"
/// message : "Sent a undefined"
/// isRead : false
/// createdAt : "2026-06-18T07:08:27.164Z"
/// updatedAt : "2026-06-18T07:08:27.164Z"
/// __v : 0

class Notifications {
  Notifications({
    String? id,
    String? toId,
    String? title,
    String? message,
    bool? isRead,
    String? createdAt,
    String? updatedAt,
    num? v,}){
    _id = id;
    _toId = toId;
    _title = title;
    _message = message;
    _isRead = isRead;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Notifications.fromJson(dynamic json) {
    _id = json['_id'];
    _toId = json['toId'];
    _title = json['title'];
    _message = json['message'];
    _isRead = json['isRead'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _toId;
  String? _title;
  String? _message;
  bool? _isRead;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Notifications copyWith({  String? id,
    String? toId,
    String? title,
    String? message,
    bool? isRead,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) => Notifications(  id: id ?? _id,
    toId: toId ?? _toId,
    title: title ?? _title,
    message: message ?? _message,
    isRead: isRead ?? _isRead,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    v: v ?? _v,
  );
  String? get id => _id;
  String? get toId => _toId;
  String? get title => _title;
  String? get message => _message;
  bool? get isRead => _isRead;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['toId'] = _toId;
    map['title'] = _title;
    map['message'] = _message;
    map['isRead'] = _isRead;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// page : 1
/// limit : 20
/// total : 3
/// totalPage : 1
/// unreadCount : 3

class Meta {
  Meta({
    num? page,
    num? limit,
    num? total,
    num? totalPage,
    num? unreadCount,}){
    _page = page;
    _limit = limit;
    _total = total;
    _totalPage = totalPage;
    _unreadCount = unreadCount;
  }

  Meta.fromJson(dynamic json) {
    _page = json['page'];
    _limit = json['limit'];
    _total = json['total'];
    _totalPage = json['totalPage'];
    _unreadCount = json['unreadCount'];
  }
  num? _page;
  num? _limit;
  num? _total;
  num? _totalPage;
  num? _unreadCount;
  Meta copyWith({  num? page,
    num? limit,
    num? total,
    num? totalPage,
    num? unreadCount,
  }) => Meta(  page: page ?? _page,
    limit: limit ?? _limit,
    total: total ?? _total,
    totalPage: totalPage ?? _totalPage,
    unreadCount: unreadCount ?? _unreadCount,
  );
  num? get page => _page;
  num? get limit => _limit;
  num? get total => _total;
  num? get totalPage => _totalPage;
  num? get unreadCount => _unreadCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['limit'] = _limit;
    map['total'] = _total;
    map['totalPage'] = _totalPage;
    map['unreadCount'] = _unreadCount;
    return map;
  }

}