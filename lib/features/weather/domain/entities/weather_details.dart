class WeatherDetails {
  final String? title;
  final String? locationType;
  final String? timezone;
  final DateTime? time;
  final Parent? parent;
  final String? sunRise;
  final String? sunSet;
  final String? timezoneName;
  final int? woeId;
  final List<ConsolidatedWeather>? consolidatedWeather;

  WeatherDetails(
      {required this.title,
      required this.locationType,
      required this.timezone,
      required this.time,
      required this.consolidatedWeather,
      required this.parent,
      required this.sunRise,
      required this.sunSet,
      required this.timezoneName,
      required this.woeId});
}

class ConsolidatedWeather {
  final int? id;
  final String? weatherStateName;
  final String? weatherStateAbbr;
  final String? windDirectionCompass;
  final DateTime? created;
  final DateTime? applicableDate;
  final double? minTempInCelsius;
  final double? maxTempInCelsius;
  final double? tempInCelsius;
  final double? windSpeed;
  final double? windDirection;
  final double? airPressure;
  final int? humidity;
  final double? visibility;
  final int? predictability;

  ConsolidatedWeather(
      this.id,
      this.weatherStateName,
      this.weatherStateAbbr,
      this.windDirectionCompass,
      this.created,
      this.applicableDate,
      this.minTempInCelsius,
      this.maxTempInCelsius,
      this.tempInCelsius,
      this.windSpeed,
      this.windDirection,
      this.airPressure,
      this.humidity,
      this.visibility,
      this.predictability);

  double tempInFahrenheit() {
    double tempInFahrenheit = (tempInCelsius ?? 0 * 9 / 5) + 32;
    return tempInFahrenheit;
  }
}

class Parent {
  final String? title;
  final String? locationType;
  final int? woeId;
  final String? lattLong;

  Parent(this.title, this.locationType, this.woeId, this.lattLong);
}

extension DoubleExtension on num {
  double toFahrenheit() {
    double tempInFahrenheit = (this * 9 / 5) + 32;
    return tempInFahrenheit;
  }
}
