import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/models/forecast.dart';

class ForecastDisplay extends StatelessWidget {
  final List<ForecastModel> forecast;

  const ForecastDisplay({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final item = forecast[index];
        return Card(
          child: ListTile(
            leading: Image.network(
              'https://openweathermap.org/img/wn/${item.icon}@2x.png',
              width: 50,
            ),
            title: Text(
              '${item.dateTime.hour}:00 - ${item.description}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Temp: ${item.temperature}°C, Feels like: ${item.feelsLike}°C'),
                Text(
                    'Humidity: ${item.humidity}%, Cloudiness: ${item.cloudiness}%'),
                Text('Wind: ${item.windSpeed} m/s, ${item.windDeg}°'),
              ],
            ),
          ),
        );
      },
    );
  }
}
