import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_details_bloc.dart';

import '../../../domain/entities/weather_details.dart';
import '../widgets/failure_widget.dart';
import '../widgets/upcoming_weather_list.dart';
import '../widgets/weather_details_widget.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({Key? key}) : super(key: key);

  @override
  State<WeatherHomeScreen> createState() => _WeatherAppMainScreenState();
}

class _WeatherAppMainScreenState extends State<WeatherHomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    BlocProvider.of<WeatherDetailsBloc>(context)
        .add(RefreshCurrentWeatherDetails());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WeatherDetailsBloc>(context)
        .add(GetDefaultWeatherDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherDetailsBloc, WeatherDetailsState>(
        listener: (context, state) {
          _refreshController.refreshCompleted();
        },
        builder: (context, state) {
          if (state is WeatherDetailsSuccess) {
            return Scaffold(
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
                  builder: (context, state) {
                    if (state is WeatherDetailsSuccess) {
                      DateTime currentDateTime = state
                              .weatherDetails.consolidatedWeather
                              ?.elementAt(state.selectedDay)
                              .applicableDate ??
                          DateTime.now();
                      String dayName =
                          DateFormat("EEEE").format(currentDateTime);
                      return Text(
                        dayName,
                        style: Theme.of(context).textTheme.headline1,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              body: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                header: const WaterDropHeader(),
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                    child: _bodyContent(state.weatherDetails, state.isCelsius,
                        state.selectedDay)),
              ),
            );
          } else if (state is WeatherDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const FailureWidget();
          }
        },
      ),
    );
  }

  Column _bodyContent(
      WeatherDetails weatherDetails, bool isCelsius, int selectedDay) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: WeatherDetailsWidget(
              weatherDetails: weatherDetails,
              isCelsius: isCelsius,
              selectedDay: selectedDay),
        ),
        const SizedBox(
          height: 16,
        ),
        UpComingWeatherList(weatherDetails, isCelsius, selectedDay),
      ],
    );
  }
}
