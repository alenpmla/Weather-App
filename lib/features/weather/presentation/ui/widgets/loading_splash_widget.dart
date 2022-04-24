import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingSplashWidget extends StatelessWidget {
  const LoadingSplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/weather_loader.svg',
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Weather App",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
