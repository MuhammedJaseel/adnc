import 'dart:convert';
import 'package:adnc/services/http.dart';
import 'package:http/http.dart' as http;

class AuthService {
  /// Sends an OTP to the given email address
  Future<Map<String, dynamic>> verifyEmail(String email) async {
    final url = HttpsService.makeUri('/api/auth/employee/login-by-otp');

    final response = await http.post(
      url,
      headers: HttpsService.defaultHeaders,
      body: jsonEncode({'email': email}),
    );

    return HttpsService.parseResponse(response);
  }

  /// Verifies the OTP token and code entered by the user
  Future<Map<String, dynamic>> verifyOtp(String otpToken, String otp) async {
    final url = HttpsService.makeUri('/api/auth/employee/verify-otp');

    final response = await http.post(
      url,
      headers: HttpsService.defaultHeaders,
      body: jsonEncode({'otpToken': otpToken, 'otp': otp}),
    );

    return HttpsService.parseResponse(response);
  }
}
