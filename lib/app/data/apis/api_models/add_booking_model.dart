class AddBookingModel {
  AddBookingData? data;
  String? message;
  String? status;

  AddBookingModel({this.data, this.message, this.status});

  AddBookingModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AddBookingData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class AddBookingData {
  String? userId;
  String? bookingDate;
  String? providerId;
  String? jobDescription;
  String? workingHours;
  String? amount;
  String? location;
  String? lat;
  String? lon;
  int? insertedId;

  AddBookingData(
      {this.userId,
      this.bookingDate,
      this.providerId,
      this.jobDescription,
      this.workingHours,
      this.amount,
      this.location,
      this.lat,
      this.lon,
      this.insertedId});

  AddBookingData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    bookingDate = json['booking_date'];
    providerId = json['provider_id'];
    jobDescription = json['job_description'];
    workingHours = json['working_hours'];
    amount = json['amount'];
    location = json['location'];
    lat = json['lat'];
    lon = json['lon'];
    insertedId = json['inserted_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['booking_date'] = bookingDate;
    data['provider_id'] = providerId;
    data['job_description'] = jobDescription;
    data['working_hours'] = workingHours;
    data['amount'] = amount;
    data['location'] = location;
    data['lat'] = lat;
    data['lon'] = lon;
    data['inserted_id'] = insertedId;
    return data;
  }
}
