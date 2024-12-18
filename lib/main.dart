import 'package:flutter/material.dart';
import 'package:weatherapp/core/network/dio_client.dart';
import 'package:weatherapp/features/weather/data/repositories/weather_repository.dart';
import 'package:weatherapp/features/weather/presentation/pages/weather_page.dart';

void main() {
  DioClient dioClient = DioClient();
  WeatherRepository weatherRepo = WeatherRepository(dioClient: dioClient);
  runApp(App(
    weatherRepo: weatherRepo,
  ));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepo;
  const App({super.key, required this.weatherRepo});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(
        weatherRepo: weatherRepo,
      ),
    );
  }
}
