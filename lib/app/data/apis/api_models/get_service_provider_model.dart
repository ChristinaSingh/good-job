class ServiceProviderModel {
  List<ServiceProviderData>? data;
  String? message;
  String? status;

  ServiceProviderModel({this.data, this.message, this.status});

  ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ServiceProviderData>[];
      json['data'].forEach((v) {
        data!.add(ServiceProviderData.fromJson(v));
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

class ServiceProviderData {
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
  List<Reviews>? reviews;
  String? distance;
  List<Gallery>? gallery;

  ServiceProviderData(
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
      this.reviews,
      this.distance,
      this.gallery});

  ServiceProviderData.fromJson(Map<String, dynamic> json) {
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
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
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
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['distance'] = distance;
    if (gallery != null) {
      data['gallery'] = gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? id;
  String? userId;
  String? providerId;
  String? rating;
  String? message;
  String? createdAt;
  UserData? userData;

  Reviews(
      {this.id,
      this.userId,
      this.providerId,
      this.rating,
      this.message,
      this.createdAt,
      this.userData});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    rating = json['rating'];
    message = json['message'];
    createdAt = json['created_at'];
    userData =
        json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['provider_id'] = providerId;
    data['rating'] = rating;
    data['message'] = message;
    data['created_at'] = createdAt;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class UserData {
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

  UserData(
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
      this.perHourCharge});

  UserData.fromJson(Map<String, dynamic> json) {
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
