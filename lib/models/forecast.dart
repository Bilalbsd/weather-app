class ForecastModel {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int cloudiness;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final int visibility;
  final String description;
  final String icon;

  ForecastModel({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.cloudiness,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.visibility,
    required this.description,
    required this.icon,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      dateTime: DateTime.parse(json['dt_txt']), // Parse la date et l'heure
      temperature: (json['main']['temp'] as num).toDouble(), // Température
      feelsLike: (json['main']['feels_like'] as num)
          .toDouble(), // Température ressentie
      tempMin:
          (json['main']['temp_min'] as num).toDouble(), // Température minimale
      tempMax:
          (json['main']['temp_max'] as num).toDouble(), // Température maximale
      humidity: json['main']['humidity'] as int, // Humidité
      cloudiness: json['clouds']['all'] as int, // Couverture nuageuse
      windSpeed: (json['wind']['speed'] as num).toDouble(), // Vitesse du vent
      windDeg: json['wind']['deg'] as int, // Direction du vent
      windGust: (json['wind']['gust'] as num).toDouble(), // Rafales du vent
      visibility: json['visibility'] as int, // Visibilité (en mètres)
      description:
          json['weather'][0]['description'] as String, // Description météo
      icon: json['weather'][0]['icon'] as String, // Icône météo
    );
  }
}
