import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:simple_weather_app/consts.dart';

class Homepage extends StatefulWidget{
  const Homepage({super.key});
  
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Fort Wayne").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(), );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child:  Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.02,
          ),
          _currentTemp(),
          SizedBox(height: MediaQuery.sizeOf(context).height  * 0.02,
          ),
          _extraInfo(),
        ],
      )
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
        style: const TextStyle(
          fontSize: 35,
        )
    ),
    const SizedBox(
      height: 10,
    ),
    Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          DateFormat("EEEE").format(now),
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        )
    ),
        Text(
          "  ${DateFormat("d.m.y").format(now)}",
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        )
    ),
    ]
    )
    ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
            ),
          ),
        ),
        ),
        Text(_weather?.weatherDescription ?? "",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20, 
        ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text("${_weather?.temperature?.fahrenheit?.toStringAsFixed(0)}°F",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 90,
          fontWeight: FontWeight.w500,
        )
      );       
  }

  Widget _extraInfo() {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).height * 0.15,
      decoration: BoxDecoration
      (color: Colors.lightBlueAccent, 
      borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("High: ${_weather?.tempMax?.fahrenheit?.toStringAsFixed(0)}°F",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                ),
              ),
              Text("Low: ${_weather?.tempMin?.fahrenheit?.toStringAsFixed(0)}°F",
              style: const TextStyle(
                color: Colors.white,
                fontSize:15,
              ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Wind: ${(_weather?.windSpeed != null ? _weather!.windSpeed! * 2.23694 : 0).toStringAsFixed(0)} mph",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                ),
              ),
              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Colors.white,
                fontSize:15,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
