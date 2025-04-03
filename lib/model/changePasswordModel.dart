import 'dart:convert';

ChangePasswordResponseModel chngPswdfromJson(String str) => ChangePasswordResponseModel.fromJson(json.decode(str));

String chngPswdtoJson(ChangePasswordResponseModel data) => json.encode(data.toJson());

class ChangePasswordResponseModel {
  String? strCafNo;
  String? strType;
  String? strOtp;
  String? strPassword;

  ChangePasswordResponseModel({required this.strCafNo,required this.strType,required this.strOtp,required this.strPassword,});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    strCafNo = json['strCafNo'];
    strType = json['strType'];
    strOtp = json['strOtp'];
    strPassword = json['strPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCafNo'] = this.strCafNo;
    data['strType'] = this.strType;
    data['strOtp'] = this.strOtp;
    data['strPassword'] = this.strPassword;
    return data;
  }
}
