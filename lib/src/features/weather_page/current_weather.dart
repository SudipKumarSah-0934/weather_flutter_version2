import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/src/entities/weather/weather_data.dart';
import 'package:weather_flutter/src/features/weather_page/city_search_box.dart';
import 'package:weather_flutter/src/features/weather_page/current_weather_controller.dart';
import 'package:weather_flutter/src/features/weather_page/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(city, style: Theme.of(context).textTheme.headline4),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(e.toString()),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final humidity = data.humidity.toString();
    final description = data.description.toString();
    final date = data.date.toString();
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text("$temp°C", style: textTheme.headline2,),
        const SizedBox(height: 5,),
        Text(description),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today_rounded,color: Colors.white,),
            const SizedBox(width: 10.0,),
            Text(date, style: textTheme.bodyText2),
          ],
        ),
        const SizedBox(height: 5,),
        Text("Humidity: $humidity%"),
      ],
    );
  }
}
