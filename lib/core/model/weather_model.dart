class WeatherModel {
  final String cityName;
  final String description;
  final double temperature;
  final String iconUrl;

  WeatherModel({
    required this.cityName,
    required this.description,
    required this.temperature,
    required this.iconUrl,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'],
      description: json['current']['condition']['text'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      iconUrl: 'https:${json['current']['condition']['icon']}',
    );
  }

  Map<String, dynamic> toMap() => {
        'cityName': cityName,
        'description': description,
        'temperature': temperature,
        'iconUrl': iconUrl,
      };

  factory WeatherModel.fromCache(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'],
      description: json['description'],
      temperature: json['temperature'],
      iconUrl: json['iconUrl'],
    );
  }
}
