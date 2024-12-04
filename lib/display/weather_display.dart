import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp2_flutter_bilalb/models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ville et pays
            Text(
              '${weather.cityName}, ${weather.country}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Date actuelle
            Text(
              DateFormat("EEEE dd/MM à HH:mm").format(DateTime.now()),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            // Icône météo et description
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                  width: 100,
                ),
                const SizedBox(width: 10),
                Text(
                  weather.description,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Détails de la météo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Température
                Column(
                  children: [
                    const Icon(Icons.thermostat, color: Colors.blue),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text('Température'),
                  ],
                ),
                // Humidité
                Column(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blueAccent),
                    Text(
                      '${weather.humidity}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text('Humidité'),
                  ],
                ),
                // Vent
                Column(
                  children: [
                    const Icon(Icons.wind_power, color: Colors.lightBlue),
                    Text(
                      '${weather.windSpeed} m/s',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text('Vent'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Autres détails
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       'Température ressentie: ${weather.feelsLike.toStringAsFixed(1)}°C',
            //       style: const TextStyle(fontSize: 14),
            //     ),
            //     Text(
            //       'Temp. Min: ${weather.tempMin.toStringAsFixed(1)}°C, Max: ${weather.tempMax.toStringAsFixed(1)}°C',
            //       style: const TextStyle(fontSize: 14),
            //     ),
            //     Text(
            //       'Pression: ${weather.pressure} hPa',
            //       style: const TextStyle(fontSize: 14),
            //     ),
            //     Text(
            //       'Nuages: ${weather.cloudiness}%',
            //       style: const TextStyle(fontSize: 14),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
