import 'dart:convert';

CollegeInfoModel CollegeInfoModelFromJson(String str) => CollegeInfoModel.fromJson(json.decode(str));

String CollegeInfoModelToJson(CollegeInfoModel data) => json.encode(data.toJson());
class CollegeInfoModel {
  String? strColType;
  String? intDistrictId;
  String? intBlockId;
  String? strCollegename;

  CollegeInfoModel(
  {this.strColType,
        this.intDistrictId,
        this.intBlockId,
        this.strCollegename});

  CollegeInfoModel.fromJson(Map<String, dynamic> json) {
    strColType = json['strColType'];
    intDistrictId = json['intDistrictId'];
    intBlockId = json['intBlockId'];
    strCollegename = json['strCollegename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strColType'] = this.strColType;
    data['intDistrictId'] = this.intDistrictId;
    data['intBlockId'] = this.intBlockId;
    data['strCollegename'] = this.strCollegename;
    return data;
  }
}