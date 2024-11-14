import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_test/bloc/weather_bloc_bloc.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black38,
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20, top: 5),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      color: Colors.white38, fontWeight: FontWeight.w400)),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        BlocProvider(
            create: (context) => WeatherBlocBloc(),
            child: GestureDetector(
              onTap: () async {
                const LocationSettings locationSettings =
                    LocationSettings(accuracy: LocationAccuracy.high);

                Position position = await Geolocator.getCurrentPosition(
                    locationSettings: locationSettings);
                BlocProvider.of<WeatherBlocBloc>(context)
                    .add(FetchWeather(position));
                controller.clear();
              },
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black54,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                ),
              ),
            )),
        const SizedBox(
          width: 10,
        ),
        BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
          builder: (context, state) {
            return BlocProvider(
              create: (context) => WeatherBlocBloc(),
              child: GestureDetector(
                onTap: () async {
                  BlocProvider.of<WeatherBlocBloc>(context)
                      .add(FetchWeatherByCity(cityName: controller.value.text));
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black54,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
