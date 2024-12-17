class WeatherModel {
  String city;
  double temp;
  String condition;
  WeatherModel({
    required this.city,
    required this.temp,
    required this.condition,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['location']['name'],
      temp: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
    );
  }
}
