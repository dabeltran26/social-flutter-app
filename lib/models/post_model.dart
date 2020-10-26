import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
   String id;
   String userPhoto;
   String userName;
   String postPhoto;
   String caption;
   String date;
  PostModel({
    this.id,
    this.userPhoto,
    this.userName,
    this.postPhoto,
    this.caption,
    this.date,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => new PostModel(
        id: json["id"],
        userPhoto: json["userPhoto"],
        userName: json["userName"],
        postPhoto: json["postPhoto"],
        caption: json["caption"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userPhoto": userPhoto,
        "userName": userName,
        "postPhoto": postPhoto,
        "caption": caption,
        "date": date,
      };
}
