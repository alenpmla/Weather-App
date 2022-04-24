import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/core/error/exceptions.dart';

import '../utils/config_reader.dart';

abstract class HttpService {
  Future<Response> postRequest({required String path, Map bodyParams});

  Future<Response> putRequest({required String path, required Map bodyParams});

  Future<Response> getRequest(
      {required String path, Map<String, dynamic> queryParams});

  Future<Response> deleteRequest({required String path});
}

class HttpServiceImpl implements HttpService {
  final Client client;
  final ConfigReader configReader;

  HttpServiceImpl(this.client, this.configReader);

  @override
  Future<Response> postRequest(
      {required String path, Map<dynamic, dynamic>? bodyParams}) async {
    final response = await client.post(
        Uri.https(configReader.getBaseUrl(), path),
        body: jsonEncode(bodyParams),
        headers: _getHeader());
    return response;
  }

  @override
  Future<Response> getRequest(
      {required String path, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await client
          .get(Uri.https(configReader.getBaseUrl(), path, queryParams));
      return response;
    } on Exception {
      throw ServerException();
    }
  }

  @override
  Future<Response> putRequest(
      {required String path, required Map<dynamic, dynamic> bodyParams}) async {
    final response = await client.put(
        Uri.https(configReader.getBaseUrl(), path),
        body: jsonEncode(bodyParams),
        headers: _getHeader());
    return response;
  }

  @override
  Future<Response> deleteRequest({required String path}) async {
    final response = await client.delete(
        Uri.https(configReader.getBaseUrl(), path),
        headers: _getHeader());
    return response;
  }

  Map<String, String> _getHeader() => {
        'Content-Type': 'application/json',
      };
}
