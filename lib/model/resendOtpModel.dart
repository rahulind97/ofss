import 'dart:convert';

ResendOtpPageModel ResendOtpPageModelFromJson(String str) =>
    ResendOtpPageModel.fromJson(json.decode(str));

String ResendOtpPageModelToJson(ResendOtpPageModel data) =>
    json.encode(data.toJson());

class ResendOtpPageModel {
  String? strCAfNo, mobileNumber, strOtpType, type;

  ResendOtpPageModel(
      {this.strCAfNo, this.mobileNumber, this.strOtpType, this.type});

  ResendOtpPageModel.fromJson(Map<String, dynamic> json) {
    strCAfNo = json['strCAfNo'];
    mobileNumber = json['mobileNumber'];
    strOtpType = json['strOtpType'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCAfNo'] = this.strCAfNo;
    data['mobileNumber'] = this.mobileNumber;
    data['strOtpType'] = this.strOtpType;
    data['type'] = this.type;
    return data;
  }
}
