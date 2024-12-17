import 'package:weatherapp/core/network/dio_client.dart';
import 'package:weatherapp/features/weather/data/models/weather_model.dart';

class WeatherRepository {
  final DioClient dioClient;
  WeatherRepository({required this.dioClient});

  Future<WeatherModel> fetchWeather(String city) async {
    final response =
        await dioClient.dio.get('current.json', queryParameters: {'q': city});

    return WeatherModel.fromJson(response.data);
  }
}
