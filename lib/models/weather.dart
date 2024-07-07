class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double humidity;
  final double windspeed;

  Weather({required this.cityName, required this.temperature, required this.description, required this.humidity, required this.windspeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'].toDouble(),
      windspeed: json['wind']['speed'].toDouble(),
    );
  }
}
