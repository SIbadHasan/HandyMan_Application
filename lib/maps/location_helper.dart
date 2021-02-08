import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'ADD YOUR KEY HERE';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude , double longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY' ;
  }

  static Future<String> getPlaceAddress(double lat , double long) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}