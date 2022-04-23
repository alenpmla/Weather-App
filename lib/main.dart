import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/features/weather/presentation/ui/screens/weather_app_main_screen.dart';
import 'package:weather_app/injector.dart' as di;

import 'core/utils/color_constants.dart';
import 'core/utils/config_reader.dart';
import 'features/weather/presentation/bloc/search_location_bloc.dart';
import 'features/weather/presentation/bloc/weather_details_bloc.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Inject all dependencies
  await di.init();
  //Initialize config reader
  await sl<ConfigReader>().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherDetailsBloc>(create: (_) => sl<WeatherDetailsBloc>()),
        Provider<SearchLocationBloc>(create: (_) => sl<SearchLocationBloc>()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
            fontFamily: 'Avenir',
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: mainBgColor,
            backgroundColor: mainBgColor,
            cardColor: mainPanelColor,
            primaryColor: primaryColor,
            errorColor: errorColor,
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 21,
                    color: mainFontColor,
                    fontWeight: FontWeight.w900),
                headline2: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 21,
                    color: mainFontColor,
                    fontWeight: FontWeight.w500),
                bodyText1: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.w400,
                    color: mainFontColor),
                bodyText2: TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w400,
                    color: mainFontColor),
                subtitle1: TextStyle(color: subFontColor))),
        themeMode: ThemeMode.dark,
        home: const WeatherHomeScreen(),
      ),
    );
  }
}
