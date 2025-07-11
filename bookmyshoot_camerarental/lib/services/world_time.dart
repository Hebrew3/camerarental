import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for the api endpoint
  bool isDaytime = true; // true or false if the time is day
  String? error; // to store error message if any

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
        Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=$url'),
        headers: {'User-Agent': 'Mozilla/5.0'},
      );

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print(data);

        // Validate response
        if (data.containsKey('dateTime')) {
          String datetime = data['dateTime'];

          // Create datetime object
          DateTime now = DateTime.parse(datetime);

          // Set isDaytime based on hour (6am to 6pm)
          isDaytime = now.hour >= 6 && now.hour < 18;

          // Set time property
          time = DateFormat.jm().format(now);
          error = null; // clear any previous errors
        } else {
          throw Exception('Invalid API response format');
        }
      } else {
        throw Exception('Failed to load time data: ${response.statusCode}');
      }
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
      error = e.toString();
      isDaytime = true; // default to daytime
    }
  }
}