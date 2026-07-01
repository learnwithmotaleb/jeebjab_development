/// statusCode : 200
/// success : true
/// message : "Reviews retrieved successfully"
/// data : {"stats":{"averageRating":4.67,"totalReviews":3,"ratingBreakdown":{"1":0,"2":0,"3":0,"4":1,"5":2}},"meta":{"page":1,"limit":10,"total":3,"totalPage":1},"reviews":[...]}

class ReviewProfileModel {
  ReviewProfileModel({
      num? statusCode, 
      bool? success, 
      String? message, 
      Data? data,}){
    _statusCode = statusCode;
    _success = success;
    _message = message;
    _data = data;
}

  ReviewProfileModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _statusCode;
  bool? _success;
  String? _message;
  Data? _data;
ReviewProfileModel copyWith({  num? statusCode,
  bool? success,
  String? message,
  Data? data,
}) => ReviewProfileModel(  statusCode: statusCode ?? _statusCode,
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

/// stats : {"averageRating":4.67,"totalReviews":3,"ratingBreakdown":{"1":0,"2":0,"3":0,"4":1,"5":2}}
/// meta : {"page":1,"limit":10,"total":3,"totalPage":1}
/// reviews : [...]

class Data {
  Data({
      Stats? stats, 
      Meta? meta, 
      List<Reviews>? reviews,}){
    _stats = stats;
    _meta = meta;
    _reviews = reviews;
}

  Data.fromJson(dynamic json) {
    _stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  Stats? _stats;
  Meta? _meta;
  List<Reviews>? _reviews;
Data copyWith({  Stats? stats,
  Meta? meta,
  List<Reviews>? reviews,
}) => Data(  stats: stats ?? _stats,
  meta: meta ?? _meta,
  reviews: reviews ?? _reviews,
);
  Stats? get stats => _stats;
  Meta? get meta => _meta;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_stats != null) {
      map['stats'] = _stats?.toJson();
    }
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

/// averageRating : 4.67
/// totalReviews : 3
/// ratingBreakdown : {"1":0,"2":0,"3":0,"4":1,"5":2}

class Stats {
  Stats({
      num? averageRating, 
      num? totalReviews, 
      RatingBreakdown? ratingBreakdown,}){
    _averageRating = averageRating;
    _totalReviews = totalReviews;
    _ratingBreakdown = ratingBreakdown;
}

  Stats.fromJson(dynamic json) {
    _averageRating = json['averageRating'];
    _totalReviews = json['totalReviews'];
    _ratingBreakdown = json['ratingBreakdown'] != null ? RatingBreakdown.fromJson(json['ratingBreakdown']) : null;
  }
  num? _averageRating;
  num? _totalReviews;
  RatingBreakdown? _ratingBreakdown;
Stats copyWith({  num? averageRating,
  num? totalReviews,
  RatingBreakdown? ratingBreakdown,
}) => Stats(  averageRating: averageRating ?? _averageRating,
  totalReviews: totalReviews ?? _totalReviews,
  ratingBreakdown: ratingBreakdown ?? _ratingBreakdown,
);
  num? get averageRating => _averageRating;
  num? get totalReviews => _totalReviews;
  RatingBreakdown? get ratingBreakdown => _ratingBreakdown;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['averageRating'] = _averageRating;
    map['totalReviews'] = _totalReviews;
    if (_ratingBreakdown != null) {
      map['ratingBreakdown'] = _ratingBreakdown?.toJson();
    }
    return map;
  }

}

/// 1 : 0
/// 2 : 0
/// 3 : 0
/// 4 : 1
/// 5 : 2

class RatingBreakdown {
  RatingBreakdown({
      num? one,
      num? two,
      num? three,
      num? four,
      num? five,}){
    _one = one;
    _two = two;
    _three = three;
    _four = four;
    _five = five;
}

  RatingBreakdown.fromJson(dynamic json) {
    _one = json['1'];
    _two = json['2'];
    _three = json['3'];
    _four = json['4'];
    _five = json['5'];
  }
  num? _one;
  num? _two;
  num? _three;
  num? _four;
  num? _five;

RatingBreakdown copyWith({  num? one,
  num? two,
  num? three,
  num? four,
  num? five,
}) => RatingBreakdown(  one: one ?? _one,
  two: two ?? _two,
  three: three ?? _three,
  four: four ?? _four,
  five: five ?? _five,
);
  num? get one => _one;
  num? get two => _two;
  num? get three => _three;
  num? get four => _four;
  num? get five => _five;

  /// Helper to convert to Map<int, int> for the breakdown widget
  Map<int, int> toMap() {
    return {
      1: (_one ?? 0).toInt(),
      2: (_two ?? 0).toInt(),
      3: (_three ?? 0).toInt(),
      4: (_four ?? 0).toInt(),
      5: (_five ?? 0).toInt(),
    };
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1'] = _one;
    map['2'] = _two;
    map['3'] = _three;
    map['4'] = _four;
    map['5'] = _five;
    return map;
  }

}