import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/weather_details.dart';
import '../../bloc/weather_details_bloc.dart';

class SingleWeatherListItem extends StatelessWidget {
  final ConsolidatedWeather? consolidatedWeather;
  final bool isCelsius;
  final int index;

  const SingleWeatherListItem(
      this.consolidatedWeather, this.isCelsius, this.index,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black.withOpacity(0.1)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              BlocProvider.of<WeatherDetailsBloc>(context)
                  .add(ChangeCurrentDay(index));
            },
            child: Column(
              children: [
                Text(DateFormat("EEE").format(
                    consolidatedWeather?.applicableDate ?? DateTime.now())),
                const SizedBox(
                  height: 8,
                ),
                SvgPicture.network(
                  "https://www.metaweather.com/static/img/weather/${consolidatedWeather?.weatherStateAbbr}.svg",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(isCelsius
                    ? "${consolidatedWeather?.minTempInCelsius?.toInt()}\u2103/${consolidatedWeather?.maxTempInCelsius?.toInt()}\u2103"
                    : "${consolidatedWeather?.minTempInCelsius?.toFahrenheit().toInt()}\u2109/${consolidatedWeather?.maxTempInCelsius?.toFahrenheit().toInt()}\u2109")
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getUnitSymbol() => isCelsius ? "\u2103" : "\u2109";
}
