class PaymentModel {
  Data? data;
  String? message;
  String? status;

  PaymentModel({
    this.data,
    this.message,
    this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message']?.toString(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (data != null) 'data': data!.toJson(),
      'message': message,
      'status': status,
    };
  }
}

class Data {
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
  String? title;
  String? serviceId;
  String? paymentStatus;

  Data({
    this.bookingRequestId,
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
    this.title,
    this.serviceId,
    this.paymentStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      bookingRequestId: json['booking_request_id']?.toString(),
      userId: json['user_id']?.toString(),
      providerId: json['provider_id']?.toString(),
      bookingDate: json['booking_date']?.toString(),
      jobDescription: json['job_description']?.toString(),
      workingHours: json['working_hours']?.toString(),
      location: json['location']?.toString(),
      lat: json['lat']?.toString(),
      lon: json['lon']?.toString(),
      amount: json['amount']?.toString(),
      bookingRequestStatus: json['booking_request_status']?.toString(),
      bookingRequestCreatedAt: json['booking_request_created_at']?.toString(),
      bookingRequestUpdatedAt: json['booking_request_updated_at']?.toString(),
      bookingRequestDeletedAt: json['booking_request_deleted_at']?.toString(),
      title: json['title']?.toString(),
      serviceId: json['service_id']?.toString(),
      paymentStatus: json['payment_status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_request_id': bookingRequestId,
      'user_id': userId,
      'provider_id': providerId,
      'booking_date': bookingDate,
      'job_description': jobDescription,
      'working_hours': workingHours,
      'location': location,
      'lat': lat,
      'lon': lon,
      'amount': amount,
      'booking_request_status': bookingRequestStatus,
      'booking_request_created_at': bookingRequestCreatedAt,
      'booking_request_updated_at': bookingRequestUpdatedAt,
      'booking_request_deleted_at': bookingRequestDeletedAt,
      'title': title,
      'service_id': serviceId,
      'payment_status': paymentStatus,
    };
  }
}
