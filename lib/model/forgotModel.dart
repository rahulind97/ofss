import 'dart:convert';

ForgotPwd forgotFromJson(String str) => ForgotPwd.fromJson(json.decode(str));

String forgotToJson(ForgotPwd data) => json.encode(data.toJson());

class ForgotPwd {
  String? strCafNo;
  String? strType;

  ForgotPwd({required this.strCafNo,  required this.strType});

  ForgotPwd.fromJson(Map<String, dynamic> json) {
    strCafNo = json['strCafNo'];
    strType = json['type'];
   }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strCafNo'] = this.strCafNo;
    data['strType'] = this.strType;
    print("object+data"+data.toString());
    return data;
  }

}

//  var param = {
//       "strCafNo":this.barCodeNumber,
//       "strType":this.typeId
//     }