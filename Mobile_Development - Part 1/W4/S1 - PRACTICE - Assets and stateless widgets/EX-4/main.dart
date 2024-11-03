import 'package:flutter/material.dart';


// Enum for weather conditions
enum WeatherCondition { sunny, rainy, cloudy, snowy }

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Weather Forecast"),
      ),
      body: Container(
        
        color: const Color(0xff364860),
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherForecast(
                  weatherCondition: WeatherCondition.sunny,
                  maxTemperature: 30,
                  minTemperature: 27,
                  dayOfWeek: "Sun",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.cloudy,
                  maxTemperature: 25,
                  minTemperature: 20,
                  dayOfWeek: "Mon",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.rainy,
                  maxTemperature: 20,
                  minTemperature: 15,
                  dayOfWeek: "Tue",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.snowy,
                  maxTemperature: 10,
                  minTemperature: -5,
                  dayOfWeek: "Wed",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.sunny,
                  maxTemperature: 36,
                  minTemperature: 27,
                  dayOfWeek: "Thu",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.rainy,
                  maxTemperature: 26,
                  minTemperature: 19,
                  dayOfWeek: "Fri",
                ),
                WeatherForecast(
                  weatherCondition: WeatherCondition.cloudy,
                  maxTemperature: 20,
                  minTemperature: 16,
                  dayOfWeek: "Sat",
                ),
                
              ],
            ),
          ),
        ),
      )
    ),
  ));
}

class WeatherForecast extends StatelessWidget {

  final WeatherCondition weatherCondition;
  final int minTemperature;
  final int maxTemperature;
  final String dayOfWeek;

  const WeatherForecast({
    super.key,
    required this.weatherCondition,
    required this.minTemperature,
    required this.maxTemperature,
    required this.dayOfWeek
  });

  Color _getColor(){
    switch (weatherCondition) {
      case WeatherCondition.sunny:
        return Colors.yellow;
      case WeatherCondition.rainy:
        return Colors.blue;
      case WeatherCondition.cloudy:
        return Colors.grey;
      case WeatherCondition.snowy:
        return Colors.white;
    }
  }
  IconData _getIcon(){
    switch (weatherCondition) {
      case WeatherCondition.sunny:
        return Icons.sunny;
      case WeatherCondition.rainy:
        return Icons.beach_access_rounded;
      case WeatherCondition.cloudy:
        return Icons.cloud;
      case WeatherCondition.snowy:
        return Icons.ac_unit;
        
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Text(dayOfWeek,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
                ),
                const SizedBox(height: 15,),
                Icon(
                  size: 40,
                  _getIcon(),
                  color: _getColor(),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Text('${maxTemperature.toStringAsFixed(0)}°',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    ),
                    const SizedBox(width: 5),
                    Text('${minTemperature.toStringAsFixed(0)}°',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                    ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}