class LocalData {
  static String lat = '51.1657';
  static String lon = '10.4515';
  static String address = '';

  static void setLatLon(String lat, String lon, String address) {
    LocalData.lat = lat;
    LocalData.lon = lon;
    LocalData.address = address;
    print('Successfully set current location lat lon...');
  }

  static List<Map<String, String>> categoryList = [
    {
      "ser_id": "5",
      "service_name": "Caregivers",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Falseceiling.png",
      "status": "active"
    },
    {
      "ser_id": "6",
      "service_name": " Catering  services",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Engineer.png",
      "status": "active"
    },
    {
      "ser_id": "2",
      "service_name": "Electrician",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Electrician.png",
      "status": "active"
    },
    {
      "ser_id": "4",
      "service_name": "Garden maintainers",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Photographer.png",
      "status": "active"
    },
    {
      "ser_id": "3",
      "service_name": "House maintainers",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Mechanic.png",
      "status": "active"
    },
    {
      "ser_id": "1",
      "service_name": "Plumber",
      "ser_image":
          "https://s82.technorizen.com/good_job/public/uploads/services/Plumber.png",
      "status": "active"
    }
  ];
}
