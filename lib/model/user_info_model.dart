import 'dart:convert';

Userinfo userinfofromJson(String str) => Userinfo.fromJson(json.decode(str));

String userinfotoJson(Userinfo data) => json.encode(data.toJson());

class Userinfo {
  String? strCafNo;
  String? type;

  Userinfo({this.strCafNo, this.type});

  Userinfo.fromJson(Map<String, dynamic> json) {
    strCafNo = json['strCafNo'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCafNo'] = this.strCafNo;
    data['type'] = this.type;
    
    return data;
  }
}