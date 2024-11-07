import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw Exception();
    }
  }
}
