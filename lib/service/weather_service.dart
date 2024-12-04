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
      final List<dynamic> list = data['list'];

      // Obtenons la date actuelle pour filtrer les jours suivants
      DateTime currentDate = DateTime.now();

      // On va filtrer les prévisions des 5 jours suivants
      List<ForecastModel> forecastList = [];

      // Parcourir la liste des prévisions pour trouver celles des 5 jours suivants
      for (int i = 0; i < list.length; i += 8) {
        var forecastData = list[i];
        // Convertir le timestamp en DateTime
        DateTime forecastDate =
            DateTime.fromMillisecondsSinceEpoch(forecastData['dt'] * 1000);

        // Si la prévision est pour un jour après aujourd'hui, on l'ajoute à la liste
        if (forecastDate.isAfter(currentDate) && forecastList.length < 5) {
          forecastList.add(ForecastModel.fromJson(forecastData));
        }
      }

      // Retourner la liste des prévisions
      return forecastList;
    } else {
      throw Exception('Failed to fetch forecast data');
    }
  }
}
