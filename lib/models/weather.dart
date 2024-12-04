class WeatherModel {
  final String cityName;
  final String country;
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final int visibility;
  final int cloudiness;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.visibility,
    required this.cloudiness,
    required this.sunrise,
    required this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String, // Ville
      country: json['sys']['country'] as String, // Pays
      description: json['weather'][0]['description']
          as String, // Description de la météo
      icon: json['weather'][0]['icon'] as String, // Icone météo
      temperature:
          (json['main']['temp'] as num).toDouble(), // Température actuelle
      feelsLike: (json['main']['feels_like'] as num)
          .toDouble(), // Température ressentie
      tempMin:
          (json['main']['temp_min'] as num).toDouble(), // Température minimale
      tempMax:
          (json['main']['temp_max'] as num).toDouble(), // Température maximale
      pressure: json['main']['pressure'] as int, // Pression atmosphérique
      humidity: json['main']['humidity'] as int, // Humidité
      windSpeed: (json['wind']['speed'] as num).toDouble(), // Vitesse du vent
      windDeg: json['wind']['deg'] as int, // Direction du vent
      visibility: json['visibility'] as int, // Visibilité (en mètres)
      cloudiness: json['clouds']['all'] as int, // Couverture nuageuse
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] *
            1000, // Conversion du temps en secondes en DateTime
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunset'] *
            1000, // Conversion du temps en secondes en DateTime
      ),
    );
  }
}
