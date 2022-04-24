import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/weather_details.dart';
import 'package:weather_app/features/weather/presentation/ui/widgets/single_weather_list_item.dart';

class UpComingWeatherList extends StatelessWidget {
  final WeatherDetails weatherDetails;
  final int selectedDay;

  const UpComingWeatherList(this.weatherDetails, this.selectedDay, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bool isPortrait = orientation == Orientation.portrait;
    List<Widget> listItem = [];
    int itemLength = weatherDetails.consolidatedWeather?.length ?? 0;
    for (int i = 0; i < itemLength; i++) {
      ConsolidatedWeather? consolidatedWeather =
          weatherDetails.consolidatedWeather?.elementAt(i);
      listItem.add(Padding(
        padding: isPortrait
            ? EdgeInsets.only(left: i == 0 ? 16 : 0,right: 8)
            : EdgeInsets.only(top: i == 0 ? 16 : 0,bottom: 8),
        child: SingleWeatherListItem(consolidatedWeather, i, selectedDay == i),
      ));
    }
    if (isPortrait) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: listItem,
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: listItem,
        ),
      );
    }
  }
}
