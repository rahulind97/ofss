import 'dart:convert';

ApplyForSlideUpReqModel applyForSlideUpfromJson(String str) => ApplyForSlideUpReqModel.fromJson(json.decode(str));

String applyForSlideUptoJson(ApplyForSlideUpReqModel data) => json.encode(data.toJson());

class ApplyForSlideUpReqModel {
  String? strCAfNo;
  String? strOtpType;
  String? strOtp;
  String? type;

  ApplyForSlideUpReqModel({required this.strCAfNo,required this.strOtpType,required this.strOtp,required this.type,});

  ApplyForSlideUpReqModel.fromJson(Map<String, dynamic> json) {
    strCAfNo = json['strCAfNo'];
    strOtpType = json['strOtpType'];
    strOtp = json['strOtp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCAfNo'] = this.strCAfNo;
    data['strOtpType'] = this.strOtpType;
    data['strOtp'] = this.strOtp;
    data['type'] = this.type;
    return data;
  }
}
