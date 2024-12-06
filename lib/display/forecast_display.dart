import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp2_flutter_bilalb/models/forecast.dart';

class ForecastDisplay extends StatelessWidget {
  final List<ForecastModel> forecast;

  const ForecastDisplay({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Hauteur ajustée pour inclure les icônes
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Définit le défilement horizontal
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          final item = forecast[index];
          return Card(
            color: Colors.blue[200],
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            child: SizedBox(
              width: 160, // Largeur définie pour chaque élément
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icône météo
                    Image.network(
                      'https://openweathermap.org/img/wn/${item.icon}@2x.png',
                      width: 100,
                    ),
                    const SizedBox(height: 8),
                    // Heure et description
                    Text(
                      DateFormat("EEEE dd/MM").format(item.dateTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      item.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    // Ligne de détails avec icônes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Température
                        Column(
                          children: [
                            const Icon(Icons.thermostat, color: Colors.red),
                            Text(
                              '${item.temperature}°C',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        // Humidité
                        Column(
                          children: [
                            const Icon(Icons.water_drop, color: Colors.blue),
                            Text(
                              '${item.humidity}%',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        // Vent
                        Column(
                          children: [
                            const Icon(Icons.wind_power, color: Colors.green),
                            Text(
                              '${item.windSpeed} m/s',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
