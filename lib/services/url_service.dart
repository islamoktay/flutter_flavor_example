// Service files must access plug-in packages
// ignore_for_file: avoid-banned-imports
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlService {
  Future<void> launchUrl(String urlText) async {
    final Uri url = Uri.parse(urlText);
    if (!await url_launcher.launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
