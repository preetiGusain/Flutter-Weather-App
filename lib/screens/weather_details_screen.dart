import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final String city;
   const WeatherDetailsScreen({super.key, required this.city});

   @override
  _WeatherDetailsScreenState createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      await Provider.of<WeatherProvider>(context, listen: false).fetchWeather(widget.city);
  } catch (error) {
    _showErrorDialog();
  }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: const Text('Failed to fetch weather data. Please check your city name and try again.'),
        actions: <Widget>[
          TextButton(onPressed: () {
            Navigator.of(ctx).pop();
            Navigator.of(context).pop();
          }, 
          child: const Text('Ok'),
          )
        ]
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<WeatherProvider>(
          builder: (context, weatherProvider, child) {
            final weather = weatherProvider.weather;
            if (weather == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weather.cityName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${weather.temperature}°C',
                      style: const TextStyle(fontSize: 48),
                    ),
                    const SizedBox(height: 20),
                    _buildWeatherDetail(
                      icon: Icons.sunny,
                      label: 'Description',
                      value: weather.description,
                    ),
                    const SizedBox(height: 10),
                    _buildWeatherDetail(
                      icon: Icons.opacity,
                      label: 'Humidity',
                      value: '${weather.humidity}%',
                    ),
                    const SizedBox(height: 10),
                    _buildWeatherDetail(
                      icon: Icons.air,
                      label: 'Windspeed',
                      value: '${weather.windspeed} km/hr',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await _fetchWeather();
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherDetail({required IconData icon, required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}