class ChatsModel {
  List<ChatsResult>? result;
  String? message;
  String? status;

  ChatsModel({this.result, this.message, this.status});

  ChatsModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ChatsResult>[];
      json['result'].forEach((v) {
        result!.add(ChatsResult.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class ChatsResult {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? createdAt;

  ChatsResult(
      {this.id, this.senderId, this.receiverId, this.message, this.createdAt});

  ChatsResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
