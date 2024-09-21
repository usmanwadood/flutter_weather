class Weather {
  final String cityName;
  final double temperature;
  final String condition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJSON(Map<String, dynamic> json) {
    final cityName = json['name'];
    final temperature = json['main']['temp'];
    final condition = json['weather'][0]['main'];

    return Weather(
      cityName: cityName,
      temperature: temperature,
      condition: condition,
    );
  }
}
