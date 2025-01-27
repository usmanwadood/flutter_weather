import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJSON(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJSON(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> getWeatherByZipCode(String zipCode) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?zip=$zipCode&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJSON(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition();

      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      String? city = placemark[0].locality;

      return city ?? "";
    } catch (e) {
      return 'Karachi';
    }
  }
}
