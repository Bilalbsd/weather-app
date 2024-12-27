import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/models/weather.dart';
import 'package:tp2_flutter_bilalb/models/forecast.dart';
import 'package:tp2_flutter_bilalb/service/weather_service.dart';
import 'package:tp2_flutter_bilalb/display/weather_display.dart';
import 'package:tp2_flutter_bilalb/display/forecast_display.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherModel;
  List<ForecastModel>? _forecastList;
  bool _isLoading = false;
  String _error = '';

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // Récupération des données météo actuelles
      final weather = await WeatherService().getWeather(_controller.text);

      // Récupération des prévisions
      final forecast = await WeatherService().getForecast(_controller.text);

      setState(() {
        _weatherModel = weather;
        _forecastList = forecast.take(8).toList(); // 8 prévisions (24h)
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Champ de saisie pour le nom de la ville
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Entrez le nom de la ville',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Affichage du loader ou du contenu
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text(
                _error,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              )
            else if (_weatherModel != null)
              Expanded(
                child: ListView(
                  children: [
                    // Affichage de la météo actuelle
                    WeatherDisplay(weather: _weatherModel!),
                    const SizedBox(height: 20),
                    // Titre des prévisions
                    const Text(
                      'Prévisions pour les 5 prochains jours:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    // Prévisions
                    _forecastList != null
                        ? ForecastDisplay(forecast: _forecastList!)
                        : const Text(
                            'No forecast data available',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
