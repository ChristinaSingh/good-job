class UserModel {
  String? message;
  String? token;
  UserData? userData;
  String? status;

  UserModel({this.message, this.token, this.userData, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    userData =
        json['user_data'] != null ? UserData.fromJson(json['user_data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    data['status'] = status;
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
  String? professionalCertificate;
  String? drivingLicense;
  List<GalleryImages>? galleryImages;

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
      this.perHourCharge,
        this.drivingLicense,
        this.professionalCertificate,
      this.galleryImages});

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
    professionalCertificate = json['professional_certificates'];
    drivingLicense = json['driving_license'];
    perHourCharge = json['per_hour_charge'];
    if (json['gallery_images'] != null) {
      galleryImages = <GalleryImages>[];
      json['gallery_images'].forEach((v) {
        galleryImages!.add(GalleryImages.fromJson(v));
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
    data['professional_certificates'] = professionalCertificate;
    data['driving_license'] = drivingLicense;
    data['per_hour_charge'] = perHourCharge;
    if (galleryImages != null) {
      data['gallery_images'] = galleryImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GalleryImages {
  String? id;
  String? providerId;
  String? image;
  String? status;
  String? dateTime;
  String? gallery;

  GalleryImages(
      {this.id,
      this.providerId,
      this.image,
      this.status,
      this.dateTime,
      this.gallery});

  GalleryImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    image = json['image'];
    status = json['status'];
    dateTime = json['date_time'];
    gallery = json['gallery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['image'] = image;
    data['status'] = status;
    data['date_time'] = dateTime;
    data['gallery'] = gallery;
    return data;
  }
}
