import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class WeatherForecastScreen extends StatefulWidget {
  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<List<WeatherForecast>> futureForecast;

  @override
  void initState() {
    super.initState();
    futureForecast = WeatherService().fetchFiveDayForecast(31.582045, 74.329376); // Replace with desired coordinates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('5-Day Weather Forecast'),
      ),
      body: FutureBuilder<List<WeatherForecast>>(
        future: futureForecast,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final forecast = snapshot.data![index];
                return ListTile(
                  leading: BoxedIcon(
                    forecast.weatherIcon,
                    size: 40,
                    color: _getWeatherColor(forecast.description),
                  ),
                  title: Text('${forecast.date.day}/${forecast.date.month}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(forecast.description),
                      Text('${forecast.temperature.toStringAsFixed(1)}°C'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Color _getWeatherColor(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Colors.orange;
      case 'few clouds':
        return Colors.lightBlue;
      case 'scattered clouds':
        return Colors.blue;
      case 'broken clouds':
        return Colors.grey;
      case 'shower rain':
        return Colors.indigo;
      case 'rain':
        return Colors.teal;
      case 'thunderstorm':
        return Colors.deepPurple;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'mist':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String description;
  late final IconData weatherIcon; // Icon data for weather condition

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.description,
  }) {
    this.weatherIcon = _getWeatherIcon(this.description);
  }

  IconData _getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return WeatherIcons.day_sunny;
      case 'few clouds':
        return WeatherIcons.day_cloudy;
      case 'scattered clouds':
        return WeatherIcons.cloud;
      case 'broken clouds':
        return WeatherIcons.cloudy;
      case 'shower rain':
        return WeatherIcons.showers;
      case 'rain':
        return WeatherIcons.rain;
      case 'thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'snow':
        return WeatherIcons.snow;
      case 'mist':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na;
    }
  }

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}

class WeatherService {
  Future<List<WeatherForecast>> fetchFiveDayForecast(double latitude, double longitude) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=4c3f395c84b3da96af793a3c21bff3a8'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)['list'];
      return jsonList.map((data) => WeatherForecast.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load 5-day forecast data');
    }
  }
}
