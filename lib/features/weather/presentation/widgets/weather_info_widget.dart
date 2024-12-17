import 'package:flutter/material.dart';

class WeatherInfoWidget extends StatelessWidget {
  final String cityName;
  final String currentTemp;
  final String weatherEmoji;
  const WeatherInfoWidget(
      {super.key,
      required this.cityName,
      required this.currentTemp,
      required this.weatherEmoji});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          textAlign: TextAlign.center,
          cityName,
          style: const TextStyle(fontSize: 36),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              currentTemp,
              style: const TextStyle(fontSize: 36),
            ),
            Text(
              weatherEmoji,
              style: const TextStyle(fontSize: 36),
            ),
          ],
        ),
      ],
    );
  }
}
