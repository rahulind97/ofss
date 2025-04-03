import 'dart:convert';

SlideUpModel slideUpfromJson(String str) => SlideUpModel.fromJson(json.decode(str));

String slideUptoJson(SlideUpModel data) => json.encode(data.toJson());

class SlideUpModel {
  String? strCafNo;
  String? strOtpType;
  String? strOtp;
  String? type;

  SlideUpModel({required this.strCafNo,required this.strOtpType,required this.strOtp,required this.type,});

  SlideUpModel.fromJson(Map<String, dynamic> json) {
    strCafNo = json['strCAfNo'];
    strOtpType = json['strOtpType'];
    strOtp = json['strOtp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCAfNo'] = this.strCafNo;
    data['strOtpType'] = this.strOtpType;
    data['strOtp'] = this.strOtp;
    data['type'] = this.type;
    return data;
  }

}
