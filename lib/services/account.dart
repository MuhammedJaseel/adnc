import 'package:adnc/services/http.dart';
import 'package:adnc/utiles/user.dart';
import 'package:http/http.dart' as http;

class AccountService {
  // Centralized host and base headers

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
}
