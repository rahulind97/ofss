import 'dart:convert';


feedbackModel feedbackModelFromJson(String str) => feedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(feedbackModel data) => json.encode(data.toJson());
class feedbackModel {
  String? userName;
  String? userMobile;
  String? userEmail;
  String? description;

  feedbackModel(
      {required this.userName,required this.userMobile,required this.userEmail,required this.description,});

  feedbackModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userEmail = json['user_email'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['user_email'] = this.userEmail;
    data['description'] = this.description;
    return data;
  }
}