import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final city = _cityController.text;
                if (city.isNotEmpty) {
                  Provider.of<WeatherProvider>(context, listen: false).fetchWeather(city);
                }
              },
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 32),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                final weather = weatherProvider.weather;
                if (weather == null) {
                  return const Text('Enter a city to get weather information.');
                } else {
                  return Column(
                    children: [
                      Text(
                        weather.cityName,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${weather.temperature}°C',
                        style: const TextStyle(fontSize: 48),
                      ),
                      Text(
                        weather.description,
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Humidity ${weather.humidity}%',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Wind speed ${weather.windspeed}km/hr',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
