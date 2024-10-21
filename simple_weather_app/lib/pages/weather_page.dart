import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_weather_app/service/weather_service.dart';
import 'package:simple_weather_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // aip key
  final _weatherService = WeatherService('e309344b3dfcf6c3e5962125d69ce5f5');
  Weather? _weather;
  // fetch weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for current city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
}
  }

  // weather animations
    String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'assets/sunny.json'; // default animation

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'fog':
        case 'haze':
        case 'smoke':
        case 'dust':
          return 'assets/snowing.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
        case 'light intensity drizzle':
        case 'heavy intensity drizzle':
        case 'light intensity drizzle rain':
        case 'drizzle rain':
        case 'heavy intensity drizzle rain':
        case 'shower rain and drizzle':
        case 'heavy shower rain and drizzle':
        case 'shower drizzle':
        case 'light rain':
        case 'moderate rain':
        case 'heavy intensity rain':
        case 'very heavy rain':
        case 'extreme rain':
        case 'freezing rain':
        case 'light intensity shower rain':
        case 'heavy intensity shower rain':
        case 'ragged shower rain':
          return 'assets/sunny_rain.json';
        case 'thunderstorm':
        case 'thunderstorm with light rain':
        case 'thunderstorm with rain':
        case 'thunderstorm with heavy rain':
        case 'light thunderstorm':
        case 'heavy thunderstorm':
        case 'ragged thunderstorm':
        case 'thunderstorm with light drizzle':
        case 'thunderstorm with drizzle':
        case 'thunderstorm with heavy drizzle': 
          return 'assets/thunder.josn';
        case 'light snow':
        case 'snow':
        case 'heavy snow':
        case 'sleet':
        case 'light shower sleet':
        case 'shower sleet':
        case 'light rain and snow':
        case 'rain and snow':
        case 'light shower snow':
        case 'shower snow':
        case 'heavy shower snow':
          return 'assets/snow.json';
        case 'few clouds':
        case 'scattered clouds':
        case 'broken clouds':
        case 'overcast clouds':
          return 'assets/partiallycloudy.json';
        case 'clear sky':
          return 'assets/sunny.json';
        default:
          return 'assets/sunny.json';
      }
    }


  // init state
  @override
  void initState() {
    super.initState();

    // fetch weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          // city name
          Text(_weather?.cityName ?? 'loading city..'),

          // animation
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

          // temperature
          Text('${_weather?.temperature.round()}*C'),

          // main description
          Text(_weather?.mainCondition ?? ""),
        ],
        ), 
      )
    );
  }
}