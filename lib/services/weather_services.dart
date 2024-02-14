import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService{

  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'
    ));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    }
    else
      {
        throw Exception('Failed to load weather data');
      }
  }
  Future<String> getCurrentCity() async {

    //get permission
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    //convert location in placemark objects
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude,position.longitude);

    //extract the city name

    String? city = placemark[0].locality;

    return city ?? "";
  }

}