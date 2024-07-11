import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';


class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  final WeatherService _weatherService = WeatherService();

  Weather? get weather => _weather;

  Future<void> fetchWeather(String city) async {
    try {
      final weatherData = await _weatherService.fetchWeather(city);
      _weather = Weather.fromJson(weatherData);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}