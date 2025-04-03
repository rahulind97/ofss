import 'dart:convert';

Admissiondetail admissiondetailfromJson(String str) => Admissiondetail.fromJson(json.decode(str));

String admissiondetailtoJson(Admissiondetail data) => json.encode(data.toJson());

class Admissiondetail {
  String? strCAfNo;
  String? strOtpType;
  String? strOtp;
  String? type;

  Admissiondetail( { this.strCAfNo, this.strOtpType,this.strOtp,this.type,});

  Admissiondetail.fromJson(Map<String, dynamic> json) {
    strCAfNo = json['strCAfNo'];
    strOtpType = json["strOtpType"];
    strOtp = json["strOtp"];
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
