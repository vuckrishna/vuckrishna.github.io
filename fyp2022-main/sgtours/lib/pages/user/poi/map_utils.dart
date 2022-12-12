import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude, String queryId) async
  {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$queryId";

    if (await canLaunch(googleMapUrl)) {
      await launch(googleMapUrl);
    } else {
      throw 'Could not open the Map';
    }
  }
}
