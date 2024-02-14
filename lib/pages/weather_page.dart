import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherServices = WeatherService('0c1fb35a3dbab5c17204f85c160ad72d');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get city
    String cityName = await _weatherServices.getCurrentCity();

    //get weather
    try{
      final weather = await _weatherServices.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error occurs
    catch (e){
      print(e);
    }
  }

  //weather animation

  //init state
  @override
  void initstate(){
    super.initState();

  //fetch weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      //city name
      Text(_weather?.cityName ?? "Loading city"),

      //Tempreture
      Text("${_weather?.temperature.round()}C")
    ]),
  ),

    );
  }
}
