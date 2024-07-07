import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    final weatherData = await _weatherService.fetchWeather(city);
    _weather = Weather.fromJson(weatherData);
    notifyListeners();
  }
}
