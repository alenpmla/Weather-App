import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/color_constants.dart';
import '../../bloc/weather_details_bloc.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_amber_outlined,
          size: 30,
          color: subFontColor,
        ),
        const SizedBox(
          height: 20,
        ),
        Text("Failed to load data",
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
        const SizedBox(
          height: 8,
        ),
        CupertinoButton(
          onPressed: () {
            BlocProvider.of<WeatherDetailsBloc>(context)
                .add(GetDefaultWeatherDetailsEvent());
          },
          child: Text(
            'Retry',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        )
      ],
    ));
  }
}
