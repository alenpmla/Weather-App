import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';
import 'package:weather_app/features/weather/presentation/ui/widgets/single_weather_list_item.dart';

class UpComingWeatherList extends StatelessWidget {
  final WeatherDetails weatherDetails;
  final bool isCelsius;

  const UpComingWeatherList(this.weatherDetails, this.isCelsius, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listItem = [];
    int itemLength = weatherDetails.consolidatedWeather?.length ?? 0;
    for (int i = 0; i < itemLength; i++) {
      ConsolidatedWeather? consolidatedWeather =
          weatherDetails.consolidatedWeather?.elementAt(i);
      listItem.add(Padding(
        padding: EdgeInsets.only(left: i == 0 ? 16 : 0),
        child: SingleWeatherListItem(consolidatedWeather, isCelsius,i),
      ));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: listItem,
      ),
    );
  }
}
