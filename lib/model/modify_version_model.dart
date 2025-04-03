
import 'dart:convert';

ModifyVersionModel modifyVersionModelFromJson(String str) => ModifyVersionModel.fromJson(json.decode(str));

String modifyVersionModelToJson(ModifyVersionModel data) => json.encode(data.toJson());

class ModifyVersionModel {
    ModifyVersionModel({
        required this.modifyVersionResult,
    });

    ModifyVersionResult modifyVersionResult;

    factory ModifyVersionModel.fromJson(Map<dynamic, dynamic> json) => ModifyVersionModel(
        modifyVersionResult: ModifyVersionResult.fromJson(json["ModifyVersionResult"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "ModifyVersionResult": modifyVersionResult.toJson(),
    };
}

class ModifyVersionResult {
    ModifyVersionResult({
        required this.errorMsg,
        required this.status,
    });

    String errorMsg;
    String status;

    factory ModifyVersionResult.fromJson(Map<dynamic, dynamic> json) => ModifyVersionResult(
        errorMsg: json["error_msg"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "error_msg": errorMsg,
        "status": status,
    };
}
