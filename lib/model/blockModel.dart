class BlockModel {
  List<GetBlockResult>? getBlockResult;

  BlockModel(this.getBlockResult);

  BlockModel.fromJson(Map<String, dynamic> json) {
    if (json['get_blockResult'] != null) {
      getBlockResult = <GetBlockResult>[];
      json['get_blockResult'].forEach((v) {
        getBlockResult!.add(new GetBlockResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getBlockResult != null) {
      data['get_blockResult'] =
          this.getBlockResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetBlockResult {
  String? blockId;
  String? blockName;
  String? distId;

  GetBlockResult({required this.blockId, required this.blockName, required this.distId});

  GetBlockResult.fromJson(Map<String, dynamic> json) {
    blockId = json['block_id'];
    blockName = json['block_name'];
    distId = json['dist_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['block_id'] = this.blockId;
    data['block_name'] = this.blockName;
    data['dist_id'] = this.distId;
    return data;
  }
}