import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weatherapp/core/constants.dart';
import 'package:weatherapp/features/weather/data/repositories/weather_repository.dart';
import 'package:weatherapp/features/weather/presentation/widgets/weather_info_widget.dart';

class WeatherPage extends StatefulWidget {
  final WeatherRepository weatherRepo;
  const WeatherPage({super.key, required this.weatherRepo});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController controller = TextEditingController();
  String cityName = 'Earth';
  String currentTemp = '0';
  String weatherEmoji = '✨';

  late Timer timer;
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      fetchWeather('Омск');
    });
    super.initState();
  }

  void startTimer(String city) {
    timer = Timer.periodic(const Duration(hours: 1), (timer) {
      fetchWeather(city);
    });
  }

  void showErr() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          textAlign: TextAlign.center,
          "Something went wrong. Please try again later",
          style: TextStyle(color: Colors.red),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void fetchWeather(String city) async {
    setState(() {
      isLoading = true;
      controller.clear();
    });

    try {
      final weather = await widget.weatherRepo.fetchWeather(city);

      cityName = weather.city.toString();
      weatherEmoji = weatherEmojis[weather.condition.toLowerCase()] ?? '✨';
      currentTemp = weather.temp.round().toString();
      isLoading = false;
      startTimer(cityName);
      setState(() {});
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(
          TextSpan(text: 'Current weather ', children: [
            TextSpan(
                text: isLoading ? "on Earth" : 'in $cityName $weatherEmoji',
                style:
                    const TextStyle(color: Color.fromARGB(255, 8, 146, 226))),
          ]),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : WeatherInfoWidget(
                      cityName: cityName,
                      currentTemp: currentTemp,
                      weatherEmoji: weatherEmoji,
                    ),
              const Spacer(),
              SizedBox(
                height: 55,
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: controller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 8, 146, 226))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 8, 146, 226))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 8, 146, 226))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            width: 2, color: Color.fromARGB(255, 8, 146, 226))),
                    suffix: TextButton(
                        onPressed: () => controller.text.isEmpty
                            ? null
                            : fetchWeather(
                                controller.text.trim(),
                              ),
                        child: const Icon(
                          color: Colors.blue,
                          Icons.refresh,
                          size: 20,
                        )),
                    // label: const Text("Change City"),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
