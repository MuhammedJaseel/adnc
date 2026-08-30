import 'dart:convert';

import 'package:adnc/services/http.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AttendanceService {
  Future<Map<String, dynamic>> getAllAttendance() async {
    final url = HttpsService.makeUri('/employee/api/attendance');

    final response = await http.get(
      url,
      headers: {
        ...HttpsService.defaultHeaders,
        'Authorization': 'Bearer ${HttpsService.accessToken}',
      },
    );

    return HttpsService.parseResponse(response);
  }

  Future<Map<String, dynamic>> markPunchIn(
    Map<String, String> body,
    XFile photo,
  ) async {
    final url = HttpsService.makeUri('/employee/api/attendance/check-in');

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      ...HttpsService.defaultHeaders,
      'Authorization': 'Bearer ${HttpsService.accessToken}',
    });

    request.fields['data'] = jsonEncode(body);
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpsService.parseResponse(response);
  }

  Future<Map<String, dynamic>> markPunchOut(
    Map<String, String> body,
    XFile photo,
  ) async {
    final url = HttpsService.makeUri('/employee/api/attendance/check-out');

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      ...HttpsService.defaultHeaders,
      'Authorization': 'Bearer ${HttpsService.accessToken}',
    });

    request.fields['data'] = jsonEncode(body);
    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        photo.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpsService.parseResponse(response);
  }
}
