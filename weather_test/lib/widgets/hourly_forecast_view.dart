import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/data/scroll_behavior.dart';

class HourlyForecastView extends StatelessWidget {
  final List<Weather> weather;
  const HourlyForecastView({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 15,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final tileWeather = weather[index];

            return SizedBox(
              child: HourlyForcastTile(
                  id: tileWeather.weatherConditionCode!,
                  hour: tileWeather.date!,
                  temp: tileWeather.temperature!.celsius!.round(),
                  isActive: index == 0),
            );
          },
        ),
      ),
    );
  }
}

class HourlyForcastTile extends StatelessWidget {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  const HourlyForcastTile({
    super.key,
    required this.id,
    required this.hour,
    required this.temp,
    required this.isActive,
  });

  final int id;
  final dynamic hour;
  final int temp;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        top: 12,
        bottom: 12,
      ),
      child: Material(
        color: isActive
            ? const Color.fromARGB(255, 42, 52, 83)
            : const Color.fromARGB(255, 16, 22, 39),
        borderRadius: BorderRadius.circular(15.0),
        elevation: isActive ? 8 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getWeatherIcon(id),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('dd •').add_jm().format(hour),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$temp°',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
