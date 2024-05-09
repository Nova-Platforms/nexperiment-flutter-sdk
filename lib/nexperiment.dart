import 'dart:convert';
import 'package:dio/dio.dart';

import 'models/toggle.dart';
import 'models/config.dart';

class Nexperiment {
  late String _baseUrl;

  late Map<String, dynamic> _context = {};
  Map<String, dynamic> get context => _context;

  late String _token;

  Nexperiment();

  Future<void> init(String baseUrl, String apiKey, String apiSecret) async {
    _baseUrl = baseUrl;

    Dio dio = Dio();
    Response response = await dio.post('$_baseUrl/v1/client/auth',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-api-key': apiKey,
            'x-api-secret': apiSecret,
          },
        ));

    if (response.statusCode == 200) {
      _token = response.data["token"];
    } else {
      throw (Exception('Was not possible initialize the Nexperiment SDK'));
    }
  }

  void setContext(Map<String, dynamic> newContext) {
    _context = newContext;
  }

  Future<Toggle> getToggle(String key) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        '$_baseUrl/v1/client/feature-toggle/$key',
        data: {'context': _context},
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': "bearer $_token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return Toggle(response.data["objectId"], response.data["appliedRuleId"], response.data["value"]);
      } else {
        throw Exception('Failed to fetch feature toggle');
      }
    } catch (e) {
      throw Exception('Failed to fetch feature toggle: $e');
    }
  }

  Future<Config> getConfig(String key) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        '$_baseUrl/v1/client/remote-config/$key',
        data: {'context': _context},
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': "bearer $_token",
          },
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.data["value"].toString());

        return Config(response.data["objectId"], response.data["appliedRuleId"], json);
      } else {
        throw Exception('Failed to fetch feature toggle');
      }
    } catch (e) {
      throw Exception('Failed to fetch feature toggle: $e');
    }
  }
}
