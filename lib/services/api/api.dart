import 'dart:async';
import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';

class Api {
  HttpClientWithInterceptor client;

  Api({this.client});
  Future<Map<String, dynamic>> get({String path}) async {
    Map<String, dynamic> resData;
    try {
      final response = await client.get("$path");
      if (response.statusCode == 200) {
        print("OK: code[${response.statusCode}]");
        resData = jsonDecode(response.body) as Map;
      } else {
        resData = jsonDecode(response.body) as Map;
        print(Future.error(
          "Error while performing a GET request, code[${response.statusCode}]",
          StackTrace.fromString("${response.body}"),
        ));
      }
    } catch (e) {
      print(e);
    }
    return resData;
  }

  Future<dynamic> post({String path, Map<String, dynamic> data}) async {
    var resData;
    try {
      final response = await client.post("$path", body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("OK: code[${response.statusCode}]");
        resData = jsonDecode(response.body) as List;
      } else {
        return Future.error(
          "Error while performing a POST request, code[${response.statusCode}]",
          StackTrace.fromString("${response.body}"),
        );
      }
    } catch (e) {
      print(e);
    }
    return resData;
  }

  Future<dynamic> patch({String path, Map<String, dynamic> data}) async {
    var resData;
    try {
      final response = await client.patch("$path", body: jsonEncode(data));

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("OK: code[${response.statusCode}]");
        resData = jsonDecode(response.body) as List;
      } else {
        return Future.error(
          "Error while performing a PATCH request, code[${response.statusCode}]",
          StackTrace.fromString("${response.body}"),
        );
      }
    } catch (e) {
      print(e);
    }
    return resData;
  }

  Future<dynamic> delete({String path}) async {
    var resData;
    try {
      final response = await client.delete("$path");
      if (response.statusCode == 200 || response.statusCode == 204) {
        print("OK: code[${response.statusCode}]");
        resData = jsonDecode(response.body) as List;
      } else {
        return Future.error(
          "Error while performing a DELETE request, code[${response.statusCode}]",
          StackTrace.fromString("${response.body}"),
        );
      }
    } catch (e) {
      print(e);
    }
    return resData;
  }
}
