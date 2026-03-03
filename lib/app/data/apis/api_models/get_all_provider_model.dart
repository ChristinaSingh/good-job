class AllProviderModel {
  List<AllProviderData>? data;
  String? message;
  String? status;

  AllProviderModel({this.data, this.message, this.status});

  AllProviderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllProviderData>[];
      json['data'].forEach((v) {
        data!.add(AllProviderData.fromJson(v));
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

class AllProviderData {
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
  String? lon;
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
  String? distance;
  List<Gallery>? gallery;

  AllProviderData(
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
      this.lon,
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
      this.distance,
      this.gallery});

  AllProviderData.fromJson(Map<String, dynamic> json) {
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
    lon = json['lon'];
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
    distance = json['distance'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(Gallery.fromJson(v));
      });
    }
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
    data['lon'] = lon;
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
    data['distance'] = distance;
    if (gallery != null) {
      data['gallery'] = gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery {
  String? id;
  String? image;

  Gallery({this.id, this.image});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
