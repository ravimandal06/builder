import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  static final client = http.Client();
  static final storage = FlutterSecureStorage();
  static Future<String> post(var body, String endpoint) async {
    print(buildUrl(endpoint));
    print(body);
    var response = await client.post(buildUrl(endpoint),
        body: body, headers: {"Content-type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 500) {
      print("Error ${response}");
    }
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Error";
  }

  static var response;

  static Future<http.Response> get(String endpoint) async {
    try {
      var response = await client.get(buildUrl(endpoint));
      // print(response.statusCode);
      // var data = jsonDecode(response.body);
      // print("data == > ${data}");
      return response;
    } catch (e) {
      print(e);
    }
    return response;
  }

  static Future<String> delete(String endpoint, Object body) async {
    try {
      var response = await client.delete(buildUrl(endpoint), body: body);
      return response.body;
    } catch (e) {
      print("Error occured in deleting grocery item");
      print(e);
    }
    return response;
  }

  static buildUrl(String endpoint) {
    // https://wholesomeeten.gives
    String host = "http://localhost:4000/we/";
    final apiPath = host + endpoint;
    print(apiPath);
    return Uri.parse(apiPath);
  }

  static Future<void> storeToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<void> storeUserId(String userId) async {
    await storage.write(key: "userId", value: userId);
  }

  static Future<String?> getuserId() async {
    return await storage.read(key: "userId");
  }
}
