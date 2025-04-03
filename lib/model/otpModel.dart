

import 'dart:convert';

OtpPageModel OtpPageModelFromJson(String str) => OtpPageModel.fromJson(json.decode(str));

String OtpPageModelToJson(OtpPageModel data) => json.encode(data.toJson());
class OtpPageModel {
  String? strOtp;
  String? strOtpType;
  String? strCAfNo;
  String? type;

  OtpPageModel({this.strOtp, this.strOtpType, this.strCAfNo, this.type});

  OtpPageModel.fromJson(Map<String, dynamic> json) {
    strOtp = json['strOtp'];
    strOtpType = json['strOtpType'];
    strCAfNo = json['strCAfNo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strOtp'] = this.strOtp;
    data['strOtpType'] = this.strOtpType;
    data['strCAfNo'] = this.strCAfNo;
    data['type'] = this.type;
    return data;
  }
}