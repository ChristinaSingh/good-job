class ContactInfoModel {
  ContactInfoResult? result;
  String? message;
  String? status;

  ContactInfoModel({this.result, this.message, this.status});

  ContactInfoModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null
        ? ContactInfoResult.fromJson(json['result'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class ContactInfoResult {
  String? id;
  String? phone;
  String? email;
  String? address;
  String? createdAt;

  ContactInfoResult(
      {this.id, this.phone, this.email, this.address, this.createdAt});

  ContactInfoResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['created_at'] = createdAt;
    return data;
  }
}
