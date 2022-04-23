import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';

import '../../bloc/weather_details_bloc.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDetails weatherDetails;
  final bool isCelsius;
  final int selectedDay;

  const WeatherDetailsWidget(
      {required this.weatherDetails,
      Key? key,
      required this.isCelsius,
      required this.selectedDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConsolidatedWeather? consolidatedWeather =
        weatherDetails.consolidatedWeather?.elementAt(selectedDay);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${consolidatedWeather?.weatherStateName} ",
            style:
                GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 16,
        ),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
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
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w400)),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(Icons.add_location)
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
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: () {
              BlocProvider.of<WeatherDetailsBloc>(context)
                  .add(ChangeWeatherUnitEvent());
            },
            child: Text(
                isCelsius
                    ? "${consolidatedWeather?.tempInCelsius?.toInt()}\u2103"
                    : "${consolidatedWeather?.tempInCelsius?.toFahrenheit().toInt()}\u2109",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 55, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text("Humidity: ${consolidatedWeather?.humidity}%",
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 8,
        ),
        Text("Pressure: ${consolidatedWeather?.airPressure} hPa",
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(
          height: 8,
        ),
        Text("Wind: ${consolidatedWeather?.windSpeed?.toStringAsFixed(1)} km/h",
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
