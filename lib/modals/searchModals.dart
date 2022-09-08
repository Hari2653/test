// To parse this JSON data, do
//
//     final searchModal = searchModalFromJson(jsonString);

import 'dart:convert';

SearchModal searchModalFromJson(String str) =>
    SearchModal.fromJson(json.decode(str));

String searchModalToJson(SearchModal data) => json.encode(data.toJson());

class SearchModal {
  SearchModal({
    this.total,
    this.totalHits,
    this.hits,
  });

  int? total;
  int? totalHits;
  List<Hit>? hits;

  factory SearchModal.fromJson(Map<String, dynamic> json) => SearchModal(
        total: json["total"] == null ? null : json["total"],
        totalHits: json["totalHits"] == null ? null : json["totalHits"],
        hits: json["hits"] == null
            ? null
            : List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "totalHits": totalHits == null ? null : totalHits,
        "hits": hits == null
            ? null
            : List<dynamic>.from(hits!.map((x) => x.toJson())),
      };
}

class Hit {
  Hit({
    this.id,
    this.pageUrl,
    this.type,
    this.tags,
    this.previewUrl,
    this.previewWidth,
    this.previewHeight,
    this.webformatUrl,
    this.webformatWidth,
    this.webformatHeight,
    this.largeImageUrl,
    this.imageWidth,
    this.imageHeight,
    this.imageSize,
    this.views,
    this.downloads,
    this.collections,
    this.likes,
    this.comments,
    this.userId,
    this.user,
    this.userImageUrl,
  });

  int? id;
  String? pageUrl;
  Type? type;
  String? tags;
  String? previewUrl;
  int? previewWidth;
  int? previewHeight;
  String? webformatUrl;
  int? webformatWidth;
  int? webformatHeight;
  String? largeImageUrl;
  int? imageWidth;
  int? imageHeight;
  int? imageSize;
  int? views;
  int? downloads;
  int? collections;
  int? likes;
  int? comments;
  int? userId;
  String? user;
  String? userImageUrl;

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"] == null ? null : json["id"],
        pageUrl: json["pageURL"] == null ? null : json["pageURL"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        tags: json["tags"] == null ? null : json["tags"],
        previewUrl: json["previewURL"] == null ? null : json["previewURL"],
        previewWidth:
            json["previewWidth"] == null ? null : json["previewWidth"],
        previewHeight:
            json["previewHeight"] == null ? null : json["previewHeight"],
        webformatUrl:
            json["webformatURL"] == null ? null : json["webformatURL"],
        webformatWidth:
            json["webformatWidth"] == null ? null : json["webformatWidth"],
        webformatHeight:
            json["webformatHeight"] == null ? null : json["webformatHeight"],
        largeImageUrl:
            json["largeImageURL"] == null ? null : json["largeImageURL"],
        imageWidth: json["imageWidth"] == null ? null : json["imageWidth"],
        imageHeight: json["imageHeight"] == null ? null : json["imageHeight"],
        imageSize: json["imageSize"] == null ? null : json["imageSize"],
        views: json["views"] == null ? null : json["views"],
        downloads: json["downloads"] == null ? null : json["downloads"],
        collections: json["collections"] == null ? null : json["collections"],
        likes: json["likes"] == null ? null : json["likes"],
        comments: json["comments"] == null ? null : json["comments"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        userImageUrl:
            json["userImageURL"] == null ? null : json["userImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "pageURL": pageUrl == null ? null : pageUrl,
        "type": type == null ? null : typeValues.reverse[type],
        "tags": tags == null ? null : tags,
        "previewURL": previewUrl == null ? null : previewUrl,
        "previewWidth": previewWidth == null ? null : previewWidth,
        "previewHeight": previewHeight == null ? null : previewHeight,
        "webformatURL": webformatUrl == null ? null : webformatUrl,
        "webformatWidth": webformatWidth == null ? null : webformatWidth,
        "webformatHeight": webformatHeight == null ? null : webformatHeight,
        "largeImageURL": largeImageUrl == null ? null : largeImageUrl,
        "imageWidth": imageWidth == null ? null : imageWidth,
        "imageHeight": imageHeight == null ? null : imageHeight,
        "imageSize": imageSize == null ? null : imageSize,
        "views": views == null ? null : views,
        "downloads": downloads == null ? null : downloads,
        "collections": collections == null ? null : collections,
        "likes": likes == null ? null : likes,
        "comments": comments == null ? null : comments,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "userImageURL": userImageUrl == null ? null : userImageUrl,
      };
}

enum Type { PHOTO, VECTOR_SVG, ILLUSTRATION }

final typeValues = EnumValues({
  "illustration": Type.ILLUSTRATION,
  "photo": Type.PHOTO,
  "vector/svg": Type.VECTOR_SVG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
