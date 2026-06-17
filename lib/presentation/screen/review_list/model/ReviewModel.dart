/// statusCode : 200
/// success : true
/// message : "Reviews retrieved successfully"
/// data : {"meta":{"page":1,"limit":10,"total":3,"totalPage":1},"reviews":[{"_id":"6a321dda0b29f944700a3ce1","post":{"_id":"6a321d150b29f944700a3c4c","type":"move","title":"The River","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":5,"comment":"nece man you are great man","createdAt":"2026-06-17T04:08:58.550Z","updatedAt":"2026-06-17T04:08:58.550Z","__v":0},{"_id":"6a321a9e0b29f944700a3c11","post":{"_id":"6a3219de0b29f944700a3b96","type":"move","title":"walton","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":5,"comment":"wow nice post","createdAt":"2026-06-17T03:55:10.532Z","updatedAt":"2026-06-17T03:55:10.532Z","__v":0},{"_id":"6a32171d0b29f944700a3b75","post":{"_id":"6a30fc637224bd1f7faee2bf","type":"move","title":"brazil","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":4,"comment":"wow nice post","createdAt":"2026-06-17T03:40:13.445Z","updatedAt":"2026-06-17T03:40:13.445Z","__v":0}]}

class ReviewModel {
  ReviewModel({
      num? statusCode, 
      bool? success, 
      String? message, 
      Data? data,}){
    _statusCode = statusCode;
    _success = success;
    _message = message;
    _data = data;
}

  ReviewModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  bool? _success;
  String? _message;
  Data? _data;
ReviewModel copyWith({  num? statusCode,
  bool? success,
  String? message,
  Data? data,
}) => ReviewModel(  statusCode: statusCode ?? _statusCode,
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

/// meta : {"page":1,"limit":10,"total":3,"totalPage":1}
/// reviews : [{"_id":"6a321dda0b29f944700a3ce1","post":{"_id":"6a321d150b29f944700a3c4c","type":"move","title":"The River","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":5,"comment":"nece man you are great man","createdAt":"2026-06-17T04:08:58.550Z","updatedAt":"2026-06-17T04:08:58.550Z","__v":0},{"_id":"6a321a9e0b29f944700a3c11","post":{"_id":"6a3219de0b29f944700a3b96","type":"move","title":"walton","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":5,"comment":"wow nice post","createdAt":"2026-06-17T03:55:10.532Z","updatedAt":"2026-06-17T03:55:10.532Z","__v":0},{"_id":"6a32171d0b29f944700a3b75","post":{"_id":"6a30fc637224bd1f7faee2bf","type":"move","title":"brazil","size":"medium"},"reviewer":{"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null},"reviewee":"6a07cab6d26aa947309412d3","reviewType":"userToDriver","rating":4,"comment":"wow nice post","createdAt":"2026-06-17T03:40:13.445Z","updatedAt":"2026-06-17T03:40:13.445Z","__v":0}]

class Data {
  Data({
      Meta? meta, 
      List<Reviews>? reviews,}){
    _meta = meta;
    _reviews = reviews;
}

  Data.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  Meta? _meta;
  List<Reviews>? _reviews;
Data copyWith({  Meta? meta,
  List<Reviews>? reviews,
}) => Data(  meta: meta ?? _meta,
  reviews: reviews ?? _reviews,
);
  Meta? get meta => _meta;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6a321dda0b29f944700a3ce1"
/// post : {"_id":"6a321d150b29f944700a3c4c","type":"move","title":"The River","size":"medium"}
/// reviewer : {"_id":"6a1fe7169cb145fcff357887","name":"jeebjabuser","avatar":null}
/// reviewee : "6a07cab6d26aa947309412d3"
/// reviewType : "userToDriver"
/// rating : 5
/// comment : "nece man you are great man"
/// createdAt : "2026-06-17T04:08:58.550Z"
/// updatedAt : "2026-06-17T04:08:58.550Z"
/// __v : 0

class Reviews {
  Reviews({
      String? id, 
      Post? post, 
      Reviewer? reviewer, 
      String? reviewee, 
      String? reviewType, 
      num? rating, 
      String? comment, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _post = post;
    _reviewer = reviewer;
    _reviewee = reviewee;
    _reviewType = reviewType;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Reviews.fromJson(dynamic json) {
    _id = json['_id'];
    _post = json['post'] != null ? Post.fromJson(json['post']) : null;
    _reviewer = json['reviewer'] != null ? Reviewer.fromJson(json['reviewer']) : null;
    _reviewee = json['reviewee'];
    _reviewType = json['reviewType'];
    _rating = json['rating'];
    _comment = json['comment'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  Post? _post;
  Reviewer? _reviewer;
  String? _reviewee;
  String? _reviewType;
  num? _rating;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Reviews copyWith({  String? id,
  Post? post,
  Reviewer? reviewer,
  String? reviewee,
  String? reviewType,
  num? rating,
  String? comment,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Reviews(  id: id ?? _id,
  post: post ?? _post,
  reviewer: reviewer ?? _reviewer,
  reviewee: reviewee ?? _reviewee,
  reviewType: reviewType ?? _reviewType,
  rating: rating ?? _rating,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  Post? get post => _post;
  Reviewer? get reviewer => _reviewer;
  String? get reviewee => _reviewee;
  String? get reviewType => _reviewType;
  num? get rating => _rating;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_post != null) {
      map['post'] = _post?.toJson();
    }
    if (_reviewer != null) {
      map['reviewer'] = _reviewer?.toJson();
    }
    map['reviewee'] = _reviewee;
    map['reviewType'] = _reviewType;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// _id : "6a1fe7169cb145fcff357887"
/// name : "jeebjabuser"
/// avatar : null

class Reviewer {
  Reviewer({
      String? id, 
      String? name, 
      dynamic avatar,}){
    _id = id;
    _name = name;
    _avatar = avatar;
}

  Reviewer.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _avatar = json['avatar'];
  }
  String? _id;
  String? _name;
  dynamic _avatar;
Reviewer copyWith({  String? id,
  String? name,
  dynamic avatar,
}) => Reviewer(  id: id ?? _id,
  name: name ?? _name,
  avatar: avatar ?? _avatar,
);
  String? get id => _id;
  String? get name => _name;
  dynamic get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['avatar'] = _avatar;
    return map;
  }

}

/// _id : "6a321d150b29f944700a3c4c"
/// type : "move"
/// title : "The River"
/// size : "medium"

class Post {
  Post({
      String? id, 
      String? type, 
      String? title, 
      String? size,}){
    _id = id;
    _type = type;
    _title = title;
    _size = size;
}

  Post.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _title = json['title'];
    _size = json['size'];
  }
  String? _id;
  String? _type;
  String? _title;
  String? _size;
Post copyWith({  String? id,
  String? type,
  String? title,
  String? size,
}) => Post(  id: id ?? _id,
  type: type ?? _type,
  title: title ?? _title,
  size: size ?? _size,
);
  String? get id => _id;
  String? get type => _type;
  String? get title => _title;
  String? get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['title'] = _title;
    map['size'] = _size;
    return map;
  }

}

/// page : 1
/// limit : 10
/// total : 3
/// totalPage : 1

class Meta {
  Meta({
      num? page, 
      num? limit, 
      num? total, 
      num? totalPage,}){
    _page = page;
    _limit = limit;
    _total = total;
    _totalPage = totalPage;
}

  Meta.fromJson(dynamic json) {
    _page = json['page'];
    _limit = json['limit'];
    _total = json['total'];
    _totalPage = json['totalPage'];
  }
  num? _page;
  num? _limit;
  num? _total;
  num? _totalPage;
Meta copyWith({  num? page,
  num? limit,
  num? total,
  num? totalPage,
}) => Meta(  page: page ?? _page,
  limit: limit ?? _limit,
  total: total ?? _total,
  totalPage: totalPage ?? _totalPage,
);
  num? get page => _page;
  num? get limit => _limit;
  num? get total => _total;
  num? get totalPage => _totalPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['limit'] = _limit;
    map['total'] = _total;
    map['totalPage'] = _totalPage;
    return map;
  }

}