import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String apikey;

  Secret({this.apikey = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
        apikey: jsonMap["AIzaSyDt4IftMGOpHxDJiauV-S1BbmywXcMfsbE"]);
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});
  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
