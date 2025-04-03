class GetVersion {
  GetVersionResult? getVersionResult;

  GetVersion({this.getVersionResult});

  GetVersion.fromJson(Map<String, dynamic> json) {
    getVersionResult = json['GetVersionResult'] != null
        ? new GetVersionResult.fromJson(json['GetVersionResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getVersionResult != null) {
      data['GetVersionResult'] = this.getVersionResult!.toJson();
    }
    return data;
  }
}

class GetVersionResult {
  List<VersionData>? versionData;
  String? errorMsg;
  String? status;

  GetVersionResult({this.versionData, this.errorMsg, this.status});

  GetVersionResult.fromJson(Map<String, dynamic> json) {
    if (json['VersionData'] != null) {
      versionData = <VersionData>[];
      json['VersionData'].forEach((v) {
        versionData!.add(new VersionData.fromJson(v));
      });
    }
    errorMsg = json['error_msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.versionData != null) {
      data['VersionData'] = this.versionData!.map((v) => v.toJson()).toList();
    }
    data['error_msg'] = this.errorMsg;
    data['status'] = this.status;
    return data;
  }
}

class VersionData {
  String? mandatory;
  String? version;

  VersionData({this.mandatory, this.version});

  VersionData.fromJson(Map<String, dynamic> json) {
    mandatory = json['Mandatory'];
    version = json['Version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Mandatory'] = this.mandatory;
    data['Version'] = this.version;
    return data;
  }
}
