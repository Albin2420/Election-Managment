class Url {
  static String baseUrl = 'http://40.192.6.123/api'; //prod;

  // static String baseUrl = "http://20.244.1.180/api";

  static String login = "token/";
  static String refreshToken = "token/refresh/";
  static String newvoter = "voters/";
  static String myBooth = "lsg/permitted-booths/";
  static String fetchAllvoters = "voters";
  static String updateIsOurvoter = "voters/update-is-our-voter/";
  static String serialNumber = "voters/serial-numbers/";
  static String byserialNumber = "voters/by-serial-numbers/";
  static String castVoter = "voters/bulk-update-has-voted/";
  static String status = "voters/statistics/";
}
