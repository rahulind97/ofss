

import 'dart:convert';

GetOtpPageModel GetOtpModelFromJson(String str) => GetOtpPageModel.fromJson(json.decode(str));

String GetOtpModelToJson(GetOtpPageModel data) => json.encode(data.toJson());
class GetOtpPageModel {
  String? mobileNumber;
  String? strOtpType;
  String? strCAfNo;
  String? type;

  GetOtpPageModel({this.mobileNumber, this.strOtpType, this.strCAfNo, this.type});

  GetOtpPageModel.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    strOtpType = json['strOtpType'];
    strCAfNo = json['strCAfNo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['strOtpType'] = this.strOtpType;
    data['strCAfNo'] = this.strCAfNo;
    data['type'] = this.type;
    return data;
  }
}