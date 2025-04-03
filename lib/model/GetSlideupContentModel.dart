import 'dart:convert';

GetSlideupContentModel GetContentModelFromJson(String str) => GetSlideupContentModel.fromJson(json.decode(str));

String GetContentModelToJson(GetSlideupContentModel data) => json.encode(data.toJson());

class GetSlideupContentModel {
  List<LstContent>? lstContent;
  String? msg;
  String? status;

  GetSlideupContentModel({this.lstContent, this.msg, this.status});

  GetSlideupContentModel.fromJson(Map<String, dynamic> json) {
    if (json['lstContent'] != null) {
      lstContent = <LstContent>[];
      json['lstContent'].forEach((v) {
        lstContent!.add(new LstContent.fromJson(v));
      });
    }
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstContent != null) {
      data['lstContent'] = this.lstContent!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class LstContent {
  String? strContent;
  String? strSeq;

  LstContent({this.strContent, this.strSeq});

  LstContent.fromJson(Map<String, dynamic> json) {
    strContent = json['strContent'];
    strSeq = json['strSeq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strContent'] = this.strContent;
    data['strSeq'] = this.strSeq;
    return data;
  }
}
