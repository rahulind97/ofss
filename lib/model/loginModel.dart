import 'dart:convert';

Login LoginFromJson(String str) => Login.fromJson(json.decode(str));

String LoginToJson(Login data) => json.encode(data.toJson());

class Login {
  String? mobileNumber;
  String? password;
  String? type;

  Login({required this.mobileNumber, required this.password, required this.type});

  Login.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    password = json['password'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['password'] = this.password;
    data['type'] = this.type;
    
    return data;
  }
}