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
        ],
      )
    );
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? "",
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
}