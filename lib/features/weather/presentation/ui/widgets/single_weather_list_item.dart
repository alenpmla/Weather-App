import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/presentation/bloc/app_settings_bloc.dart';

import '../../../domain/entities/weather_details.dart';
import '../../bloc/weather_details_bloc.dart';

class SingleWeatherListItem extends StatelessWidget {
  final ConsolidatedWeather? consolidatedWeather;
  final bool isSelected;
  final int index;

  const SingleWeatherListItem(
      this.consolidatedWeather, this.index, this.isSelected,
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
            color: isSelected
                ? Colors.blue.withOpacity(0.20)
                : Colors.blue.withOpacity(0.08)),
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: () {
            BlocProvider.of<WeatherDetailsBloc>(context)
                .add(ChangeCurrentDay(index));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                    DateFormat("EEE").format(
                        consolidatedWeather?.applicableDate ?? DateTime.now()),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                const SizedBox(
                  height: 16,
                ),
                SvgPicture.network(
                  "https://www.metaweather.com/static/img/weather/${consolidatedWeather?.weatherStateAbbr}.svg",
                  height: 50,
                  width: 50,
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<AppSettingsBloc, AppSettingsState>(
                  builder: (context, state) {
                    if (state is AppSettingsSuccess) {
                      return Text(
                          state.isCelsius
                              ? "${consolidatedWeather?.minTempInCelsius?.toInt()}\u2103/${consolidatedWeather?.maxTempInCelsius?.toInt()}\u2103"
                              : "${consolidatedWeather?.minTempInCelsius?.toFahrenheit().toInt()}\u2109/${consolidatedWeather?.maxTempInCelsius?.toFahrenheit().toInt()}\u2109",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 16));
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
