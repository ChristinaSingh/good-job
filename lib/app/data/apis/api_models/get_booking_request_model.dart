class BookingRequestModel {
  List<BookingRequestData>? data;
  String? message;
  String? status;

  BookingRequestModel({this.data, this.message, this.status});

  BookingRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookingRequestData>[];
      json['data'].forEach((v) {
        data!.add(BookingRequestData.fromJson(v));
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

class BookingRequestData {
  String? bookingRequestId;
  String? userId;
  String? providerId;
  String? bookingDate;
  String? jobDescription;
  String? workingHours;
  String? location;
  String? lat;
  String? lon;
  String? amount;
  String? bookingRequestStatus;
  String? bookingRequestCreatedAt;
  String? bookingRequestUpdatedAt;
  String? bookingRequestDeletedAt;
  String? distance;
  String? name;
  String? mobile;
  String? serviceName;
  String? paymentStatus;
  String? image;
  bool? upDown;
  List<BookingGallery>? bookingGallery;

  BookingRequestData(
      {this.bookingRequestId,
      this.userId,
      this.providerId,
      this.bookingDate,
      this.jobDescription,
      this.workingHours,
      this.location,
      this.lat,
      this.lon,
      this.amount,
      this.bookingRequestStatus,
      this.bookingRequestCreatedAt,
      this.bookingRequestUpdatedAt,
      this.bookingRequestDeletedAt,
      this.distance,
      this.name,
      this.mobile,
      this.serviceName,
      this.paymentStatus,
      this.image,
      this.upDown,
      this.bookingGallery});

  BookingRequestData.fromJson(Map<String, dynamic> json) {
    bookingRequestId = json['booking_request_id'];
    userId = json['user_id'];
    providerId = json['provider_id'];
    bookingDate = json['booking_date'];
    jobDescription = json['job_description'];
    workingHours = json['working_hours'];
    location = json['location'];
    lat = json['lat'];
    lon = json['lon'];
    amount = json['amount'];
    bookingRequestStatus = json['booking_request_status'];
    bookingRequestCreatedAt = json['booking_request_created_at'];
    bookingRequestUpdatedAt = json['booking_request_updated_at'];
    bookingRequestDeletedAt = json['booking_request_deleted_at'];
    distance = json['distance'];
    name = json['name'];
    mobile = json['mobile'];
    serviceName = json['service_name'];
    paymentStatus = json['payment_status'];
    image = json['image'];
    upDown = json['up_down'];
    if (json['booking_gallery'] != null) {
      bookingGallery = <BookingGallery>[];
      json['booking_gallery'].forEach((v) {
        bookingGallery!.add(BookingGallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['booking_request_id'] = bookingRequestId;
    data['user_id'] = userId;
    data['provider_id'] = providerId;
    data['booking_date'] = bookingDate;
    data['job_description'] = jobDescription;
    data['working_hours'] = workingHours;
    data['location'] = location;
    data['lat'] = lat;
    data['lon'] = lon;
    data['amount'] = amount;
    data['booking_request_status'] = bookingRequestStatus;
    data['booking_request_created_at'] = bookingRequestCreatedAt;
    data['booking_request_updated_at'] = bookingRequestUpdatedAt;
    data['booking_request_deleted_at'] = bookingRequestDeletedAt;
    data['distance'] = distance;
    data['name'] = name;
    data['mobile'] = mobile ;
    data['service_name'] = serviceName;
    data['payment_status'] = paymentStatus;
    data['image'] = image;
    data['up_down'] = upDown;
    if (bookingGallery != null) {
      data['booking_gallery'] = bookingGallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingGallery {
  String? id;
  String? image;

  BookingGallery({this.id, this.image});

  BookingGallery.fromJson(Map<String, dynamic> json) {
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
