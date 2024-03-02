import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {
  static String baseURL = "${dotenv.env['API_URL']}";
  static String basicToken = "${dotenv.env['BASIC_TOKEN']}";
  static String appVersion = "${dotenv.env['VERSION']}";
  static String appVersionSuffix = "${dotenv.env['VERSION_SUFFIX']}";
  static String buildMode = "${dotenv.env['MODE']}";
  static String webUrl = "${dotenv.env['WEB_URL']}";
  static String webViewUrl = "${dotenv.env['WEBVIEW_URL']}";
}
