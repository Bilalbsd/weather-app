// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/models/weather.dart';
import 'package:tp2_flutter_bilalb/service/weather_service.dart';
import 'package:tp2_flutter_bilalb/widgets/weather_display.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();
  WeatherModel? _weatherModel;
  bool _isLoading = false;
  String _error = '';

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
    try {
      final weather = await WeatherService().getWeather(_controller.text);
      setState(() {
        _weatherModel = weather;
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
              Text(_error, style: const TextStyle(color: Colors.red))
            else if (_weatherModel != null)
              WeatherDisplay(weather: _weatherModel!),
          ],
        ),
      ),
    );
  }
}
