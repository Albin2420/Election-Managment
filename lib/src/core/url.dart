import 'package:flutter_dotenv/flutter_dotenv.dart';

class Url {
  static String baseUrl = dotenv.env['BASE_URL'] ?? '<url not found>';

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
