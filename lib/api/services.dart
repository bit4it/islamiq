
import 'dart:convert';
import 'package:http/http.dart' as http;

class PrayerTimesResponse {
  final Map<String, String> timings;
  final Map<String, dynamic> hijriDate;
  final Map<String, dynamic> gregorianDate;

  PrayerTimesResponse({
    required this.timings,
    required this.hijriDate,
    required this.gregorianDate,
  });

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return PrayerTimesResponse(
      timings: Map<String, String>.from(data['timings']),
      hijriDate: data['date']['hijri'],
      gregorianDate: data['date']['gregorian'],
    );
  }
}

Future<PrayerTimesResponse?> fetchPrayerTimes({
  required String date,
  required double latitude,
  required double longitude,
  int method = 3,
}) async {
  final url = Uri.parse(
    'https://api.aladhan.com/v1/timings/$date?latitude=$latitude&longitude=$longitude&method=$method',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PrayerTimesResponse.fromJson(jsonData);
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}


Future<double?> fetchQiblaDirection({
  required double latitude,
  required double longitude,
}) async {
  final url = Uri.parse(
    'https://api.aladhan.com/v1/qibla/$latitude/$longitude',
  );

  try {
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['data']['direction'];
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}