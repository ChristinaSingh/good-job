class PaymentHistoryModel {
  List<PaymentHistoryData>? data;
  String? message;
  String? status;
  var totalAmount;

  PaymentHistoryModel({this.data, this.message, this.status, this.totalAmount});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentHistoryData>[];
      json['data'].forEach((v) {
        data!.add(PaymentHistoryData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    data['total_amount'] = totalAmount;
    return data;
  }
}

class PaymentHistoryData {
  String? id;
  String? amount;
  String? providerId;
  String? bookingId;
  String? createdAt;
  List<User>? user;

  PaymentHistoryData(
      {this.id,
      this.amount,
      this.providerId,
      this.bookingId,
      this.createdAt,
      this.user});

  PaymentHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    providerId = json['provider_id'];
    bookingId = json['booking_id'];
    createdAt = json['created_at'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['provider_id'] = providerId;
    data['booking_id'] = bookingId;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? userName;
  String? email;
  String? mobile;
  String? countryCode;
  String? type;
  String? jobRoleService;
  String? specialQualification;
  String? description;
  String? attribute;
  String? address;
  String? lat;
  String? long;
  String? image;
  String? gender;
  String? password;
  String? otp;
  String? accountStatus;
  String? step;
  String? updatedAt;
  String? createdAt;
  String? generalNotification;
  String? sound;
  String? vibrate;
  String? appUpdate;
  String? newTipsAvailable;
  String? newServiceAvailable;
  String? reviewCount;
  String? perHourCharge;
  String? wallet;
  String? userType;

  User(
      {this.id,
      this.userName,
      this.email,
      this.mobile,
      this.countryCode,
      this.type,
      this.jobRoleService,
      this.specialQualification,
      this.description,
      this.attribute,
      this.address,
      this.lat,
      this.long,
      this.image,
      this.gender,
      this.password,
      this.otp,
      this.accountStatus,
      this.step,
      this.updatedAt,
      this.createdAt,
      this.generalNotification,
      this.sound,
      this.vibrate,
      this.appUpdate,
      this.newTipsAvailable,
      this.newServiceAvailable,
      this.reviewCount,
      this.perHourCharge,
      this.wallet,
      this.userType});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    type = json['type'];
    jobRoleService = json['job_role_service'];
    specialQualification = json['special_qualification'];
    description = json['description'];
    attribute = json['attribute'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    image = json['image'];
    gender = json['gender'];
    password = json['password'];
    otp = json['otp'];
    accountStatus = json['account_status'];
    step = json['step'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    generalNotification = json['general_notification'];
    sound = json['sound'];
    vibrate = json['vibrate'];
    appUpdate = json['app_update'];
    newTipsAvailable = json['new_tips_available'];
    newServiceAvailable = json['new_service_available'];
    reviewCount = json['review_count'];
    perHourCharge = json['per_hour_charge'];
    wallet = json['wallet'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['country_code'] = countryCode;
    data['type'] = type;
    data['job_role_service'] = jobRoleService;
    data['special_qualification'] = specialQualification;
    data['description'] = description;
    data['attribute'] = attribute;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    data['image'] = image;
    data['gender'] = gender;
    data['password'] = password;
    data['otp'] = otp;
    data['account_status'] = accountStatus;
    data['step'] = step;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['general_notification'] = generalNotification;
    data['sound'] = sound;
    data['vibrate'] = vibrate;
    data['app_update'] = appUpdate;
    data['new_tips_available'] = newTipsAvailable;
    data['new_service_available'] = newServiceAvailable;
    data['review_count'] = reviewCount;
    data['per_hour_charge'] = perHourCharge;
    data['wallet'] = wallet;
    data['user_type'] = userType;
    return data;
  }
}
