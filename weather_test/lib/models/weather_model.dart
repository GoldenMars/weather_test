import 'package:weather/weather.dart';

class WeatherModel {
  String areaName;
  int weatherConditionCode;
  int temperature;
  String weatherMain;
  DateTime date;
  List<Weather> weather;

  WeatherModel(
      {required this.areaName,
      required this.weatherConditionCode,
      required this.temperature,
      required this.weatherMain,
      required this.date,
      required this.weather});

  WeatherModel.fromJson(Map<String, dynamic> json)
      : areaName = json['areaName'],
        weatherConditionCode = json['weatherConditionCode'],
        temperature = json['temperature'],
        weatherMain = json['weatherMain'],
        date = DateTime.parse(json['date']),
        weather = json['weather'];

  Map<String, dynamic> toJson() => {
        'areaName': areaName,
        'weatherConditionCode': weatherConditionCode,
        'temperature': temperature,
        'weatherMain': weatherMain,
        'date': date.toIso8601String(),
        'weather': weather,
      };
}
