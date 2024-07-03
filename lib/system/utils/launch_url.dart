import 'package:minddy/system/files/app_logs.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String link) async {
  try {
    final String sanitizedUrl = sanitizeUrl(link);
    final Uri url = Uri.parse(sanitizedUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  } catch (e) {
    await AppLogs.writeError("Cannot open Url. Link was $link", "launch_url.dart - launchURL");
  }
}

String sanitizeUrl(String url) {
  if (!url.startsWith(RegExp(r'http://|https://'))) {
    url = 'https://$url';
  }
  
  Uri uri = Uri.parse(url);

  if (uri.host.isEmpty && !uri.path.startsWith('www.')) {
    uri = uri.replace(host: 'www.${uri.path}');
  }

  return uri.toString();
}

String getDomain(String url) {
  if (!url.startsWith(RegExp(r'http://|https://'))) {
    url = 'https://$url';
  }

  Uri uri = Uri.parse(url);

  return uri.host.startsWith('www.') ? uri.host.substring(4) : uri.host;
}