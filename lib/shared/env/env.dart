import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Env {
  static String? _host;
  static String? _apikey;
  static String? _flavor;
  static bool _initialized = false;

  static Future<void> load() async {
    if (_initialized) return;
    const hostFromEnv = String.fromEnvironment('host');
    const apikeyFromEnv = String.fromEnvironment('apikey');
    const flavorFromEnv = String.fromEnvironment('flavor');

    if (hostFromEnv.isNotEmpty && apikeyFromEnv.isNotEmpty && flavorFromEnv.isNotEmpty) {
      _host = hostFromEnv;
      _apikey = apikeyFromEnv;
      _flavor = flavorFromEnv;
    } else {
      final content = await rootBundle.loadString('env.json');
      final jsonMap = json.decode(content);
      _host = jsonMap['baseUrl'] ?? jsonMap['host'] ?? '';
      _apikey = jsonMap['apikey'] ?? '';
      _flavor = jsonMap['flavor'] ?? '';
    }
    _initialized = true;
  }

  static String get host => _host ?? '';
  static String get apikey => _apikey ?? '';
  static String get flavor => _flavor ?? '';
}
