import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/models/weather.dart';
import 'package:tp2_flutter_bilalb/models/forecast.dart';
import 'package:tp2_flutter_bilalb/service/weather_service.dart';
import 'package:tp2_flutter_bilalb/widgets/weather_display.dart';
import 'package:tp2_flutter_bilalb/widgets/forecast_display.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherModel;
  List<ForecastModel>?
      _forecastList; // Correction : Utiliser List<ForecastModel>
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
        _forecastList = forecast
            .take(8)
            .toList(); // Les 8 premières prévisions (environ 24h)
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
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text(
                _error,
                style: const TextStyle(color: Colors.red),
              )
            else if (_weatherModel != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Affichage des données météo actuelles
                    WeatherDisplay(weather: _weatherModel!),
                    const SizedBox(height: 20),
                    // Titre pour les prévisions
                    const Text(
                      'Forecast for the next hours:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Affichage des prévisions si disponibles
                    _forecastList != null
                        ? ForecastDisplay(forecast: _forecastList!)
                        : const Text('No forecast data available'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
