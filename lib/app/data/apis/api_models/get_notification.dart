class NotificationModel {
  List<NotificationData>? data;
  String? message;
  String? status;

  NotificationModel({this.data, this.message, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(NotificationData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class NotificationData {
  String? notifyId;
  String? userId;
  String? title;
  String? body;
  String? createdAt;

  NotificationData(
      {this.notifyId, this.userId, this.title, this.body, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notifyId = json['notify_id'];
    userId = json['user_id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notify_id'] = notifyId;
    data['user_id'] = userId;
    data['title'] = title;
    data['body'] = body;
    data['created_at'] = createdAt;
    return data;
  }
}
