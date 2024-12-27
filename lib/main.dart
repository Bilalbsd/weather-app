import 'package:flutter/material.dart';
import 'package:tp2_flutter_bilalb/display/home_display.dart';
import 'package:tp2_flutter_bilalb/display/quiz_bloc_display.dart';
import 'package:tp2_flutter_bilalb/display/quiz_providers_display.dart';
import 'package:tp2_flutter_bilalb/widgets/weather_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/quiz/providers': (context) =>
            const QuizProvidersPage(title: 'Page de Quiz (Providers)'),
        '/quiz/bloc': (context) =>
            const QuizBlocPage(title: 'Page de Quiz (BLoC)'),
        '/weather': (context) => const WeatherApp(),
      },
    );
  }
}
