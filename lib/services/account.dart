import 'dart:io';

import 'package:adnc/services/http.dart';
import 'package:adnc/utiles/user.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AccountService {
  Future<String> _convertToWebP(XFile photo) async {
    final tempDir = await Directory.systemTemp.createTemp('attendance-webp-');
    final webPPath =
        '${tempDir.path}/photo_${DateTime.now().millisecondsSinceEpoch}.webp';

    final result = await FlutterImageCompress.compressAndGetFile(
      photo.path,
      webPPath,
      format: CompressFormat.webp,
      quality: 80,
    );

    if (result == null) {
      throw Exception('Unable to convert image to WebP.');
    }
    return result.path;
  }

  /// Fetches the profile details for the authenticated employee
  Future<Map<String, dynamic>> getProfile() async {
    final url = HttpsService.makeUri('/employee/api/account/profile');

    final response = await http.get(
      url,
      headers: {
        ...HttpsService.defaultHeaders,
        'Authorization': 'Bearer ${HttpsService.accessToken}',
      },
    );

    User.employee = HttpsService.parseResponse(response);
    return {};
  }

  Future<Map<String, dynamic>> getDashboard() async {
    final url = HttpsService.makeUri('/employee/api/account/dashboard');

    final response = await http.get(
      url,
      headers: {
        ...HttpsService.defaultHeaders,
        'Authorization': 'Bearer ${HttpsService.accessToken}',
      },
    );

    return HttpsService.parseResponse(response);
  }

  Future<Map<String, dynamic>> uploadSelfie(XFile photo) async {
    final url = HttpsService.makeUri('/employee/api/account/add-selfie');

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      ...HttpsService.defaultHeaders,
      'Authorization': 'Bearer ${HttpsService.accessToken}',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        await _convertToWebP(photo),
        contentType: MediaType('image', 'webp'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    return HttpsService.parseResponse(response);
  }

  Future<Map<String, dynamic>> verifySelfie(XFile photo) async {
    final url = HttpsService.makeUri('/employee/api/account/verify-selfie');

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      ...HttpsService.defaultHeaders,
      'Authorization': 'Bearer ${HttpsService.accessToken}',
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'photo',
        await _convertToWebP(photo),
        contentType: MediaType('image', 'webp'),
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    await getProfile();

    return HttpsService.parseResponse(response);
  }
}
