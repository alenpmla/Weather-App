import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/core/services/http_service.dart';

import '../../../../core/error/exceptions.dart';
import '../model/location_model.dart';
import '../model/weather_detail_model.dart';

abstract class WeatherDataSource {
  Future<List<LocationModel>> searchLocationWithQuery(String query);

  Future<List<LocationModel>> searchLocationWithLatLng(String latLng);

  Future<WeatherDetailModel> getWeatherDetails(String woeId);
}

class WeatherDataSourceImpl implements WeatherDataSource {
  final HttpService httpService;

  WeatherDataSourceImpl({required this.httpService});

  @override
  Future<List<LocationModel>> searchLocationWithQuery(String query) async {
    String path = "/api/location/search/";
    String queryKey = "query";
    return await _searchLocation(queryKey, query, path);
  }

  @override
  Future<List<LocationModel>> searchLocationWithLatLng(String latLng) async {
    String path = "/api/location/search/";
    String queryKey = "lattlong";
    return await _searchLocation(queryKey, latLng, path);
  }

  Future<List<LocationModel>> _searchLocation(
      String queryKey, String query, String path) async {
    debugPrint("query - $query");
    final queryParameters = {
      queryKey: query,
    };
    final response =
        await httpService.getRequest(path: path, queryParams: queryParameters);
    if (response.statusCode == 200) {
      final List t = json.decode(response.body);
      final List<LocationModel> performanceList =
          t.map((item) => LocationModel.fromJson(item)).toList();
      return performanceList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherDetailModel> getWeatherDetails(String woeId) async {
    String path = "/api/location/$woeId/";
    final response = await httpService.getRequest(path: path);
    if (response.statusCode == 200) {
      debugPrint("response.body - ${response.body}");
      return WeatherDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
