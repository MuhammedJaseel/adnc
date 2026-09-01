import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HttpsService {
  // static const String imageBaseUrl = 'http://10.157.213.253:2700/storage/';
  // static const String authority = '10.157.213.253:2700';
  static const String imageBaseUrl = 'https://qorfin-api.anolabs.site/storage/';
  static const String authority = 'qorfin-api.anolabs.site';

  static Uri makeUri(String path) {
    // return Uri.http(HttpsService.authority, path);
    return Uri.https(HttpsService.authority, path);
  }

  static String accessToken = '';

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  /// Handles HTTP responses and safely decodes JSON
  static Map<String, dynamic> parseResponse(http.Response response) {
    final Map<String, dynamic> body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else {
      String msg = '';
      if (body['message'] != null) {
        switch (body['message'].runtimeType) {
          case List:
            msg = body['message'].join(', ');
          default:
            msg = jsonEncode(body['message']);
        }
      } else {
        msg = 'API error: ${response.statusCode}';
      }
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw Exception(body['message'] ?? 'API error: ${response.statusCode}');
    }
  }
}
