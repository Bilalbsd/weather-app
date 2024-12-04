import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp2_flutter_bilalb/models/weather.dart';
import 'package:tp2_flutter_bilalb/models/forecast.dart';

class WeatherService {
  final String apiKey = '2d10d9f94d4d7781fe185eb71542610d';

  Future<WeatherModel> getWeather(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=fr';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<List<ForecastModel>> getForecast(String cityName) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&exclude=current,minutely,hourly,alerts&appid=$apiKey&units=metric&lang=fr';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list =
          data['list']; // Utiliser 'list' pour la prévision

      // Récupère les prévisions pour les 5 premiers jours
      return list.take(5).map((json) => ForecastModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }
}
