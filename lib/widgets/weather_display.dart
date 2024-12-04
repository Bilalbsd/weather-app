import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weather.cityName}, ${weather.country}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(weather.description, style: const TextStyle(fontSize: 18)),
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
              width: 50,
            ),
            const SizedBox(width: 10),
            Text('${weather.temperature}°C',
                style: const TextStyle(fontSize: 32)),
          ],
        ),
        Text('Feels like: ${weather.feelsLike}°C'),
        Text('Min: ${weather.tempMin}°C, Max: ${weather.tempMax}°C'),
        const SizedBox(height: 10),
        Text('Pressure: ${weather.pressure} hPa'),
        Text('Humidity: ${weather.humidity}%'),
        Text('Wind: ${weather.windSpeed} m/s, ${weather.windDeg}°'),
        Text('Visibility: ${weather.visibility / 1000} km'),
        Text('Cloudiness: ${weather.cloudiness}%'),
        const SizedBox(height: 10),
        Text(
          'Sunrise: ${TimeOfDay.fromDateTime(weather.sunrise).format(context)}',
        ),
        Text(
          'Sunset: ${TimeOfDay.fromDateTime(weather.sunset).format(context)}',
        ),
      ],
    );
  }
}
