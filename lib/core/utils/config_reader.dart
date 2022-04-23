import 'dart:convert';

import 'package:flutter/services.dart';

class ConfigReader {
  static late Map<String, dynamic> _config;

  Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString) as Map<String, dynamic>;
  }

  String getBaseUrl() {
    return _config['baseUrl'] as String;
  }
}
