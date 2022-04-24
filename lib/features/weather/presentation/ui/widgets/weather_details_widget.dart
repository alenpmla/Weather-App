import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';

import '../../../../../core/utils/color_constants.dart';
import '../../bloc/app_settings_bloc.dart';
import '../../bloc/weather_details_bloc.dart';
import '../screens/search_location_screen.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDetails weatherDetails;
  final int selectedDay;

  const WeatherDetailsWidget(
      {required this.weatherDetails, Key? key, required this.selectedDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConsolidatedWeather? consolidatedWeather =
        weatherDetails.consolidatedWeather?.elementAt(selectedDay);
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    if (isPortrait) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeatherStatus(consolidatedWeather, context),
          const SizedBox(
            height: 16,
          ),
          _weatherImage(context, consolidatedWeather),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              width: double.infinity,
              child: _buildWeatherValue(context, consolidatedWeather)),
          const SizedBox(
            height: 16,
          ),
          _buildWeatherInfo(consolidatedWeather, context),
        ],
      );
    } else {
      return Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWeatherStatus(consolidatedWeather, context),
                const SizedBox(
                  height: 16,
                ),
                _weatherImage(context, consolidatedWeather),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildWeatherValue(context, consolidatedWeather),
                _buildWeatherInfo(consolidatedWeather, context),
              ],
            ),
          )
        ],
      );
    }
  }

  Text _buildWeatherStatus(
      ConsolidatedWeather? consolidatedWeather, BuildContext context) {
    return Text("${consolidatedWeather?.weatherStateName} ",
        style: Theme.of(context).textTheme.headline2);
  }

  Column _buildWeatherInfo(
      ConsolidatedWeather? consolidatedWeather, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Humidity: ${consolidatedWeather?.humidity}%",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          height: 8,
        ),
        Text("Pressure: ${consolidatedWeather?.airPressure} hPa",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          height: 8,
        ),
        Text("Wind: ${consolidatedWeather?.windSpeed?.toStringAsFixed(1)} km/h",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
      ],
    );
  }

  Widget _buildWeatherValue(
      BuildContext context, ConsolidatedWeather? consolidatedWeather) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppSettingsBloc>(context).add(SwitchWeatherUnitEvent());
      },
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          if (state is AppSettingsSuccess) {
            return Text(
                state.isCelsius
                    ? "${consolidatedWeather?.tempInCelsius?.toInt()}\u2103"
                    : "${consolidatedWeather?.tempInCelsius?.toFahrenheit().toInt()}\u2109",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 55, fontWeight: FontWeight.bold));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _weatherImage(
      BuildContext context, ConsolidatedWeather? consolidatedWeather) {
    var brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${weatherDetails.title} ",
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          ?.copyWith(fontSize: 16)),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                      onTap: () async {
                        var woeId = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SearchLocationScreen()),
                        );
                        if (woeId != null) {
                          BlocProvider.of<WeatherDetailsBloc>(context)
                              .add(CityChangedEvent(woeId.toString()));
                        }
                      },
                      child: Icon(
                        Icons.edit_location_sharp,
                        color: isDarkMode ? mainFontColor : subFontColorLight,
                      ))
                ],
              ),
              Expanded(
                child: Center(
                  child: SvgPicture.network(
                    "https://www.metaweather.com/static/img/weather/${consolidatedWeather?.weatherStateAbbr}.svg",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
