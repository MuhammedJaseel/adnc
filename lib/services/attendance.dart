import 'package:adnc/services/http.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>> markPunchIn() async {
    final url = HttpsService.makeUri('/employee/api/attendance/punch-in');

    final response = await http.post(
      url,
      body: "{}",
      headers: {
        ...HttpsService.defaultHeaders,
        'Authorization': 'Bearer ${HttpsService.accessToken}',
      },
    );

    return HttpsService.parseResponse(response);
  }

  Future<Map<String, dynamic>> markPunchOut() async {
    final url = HttpsService.makeUri('/employee/api/attendance/punch-out');

    final response = await http.post(
      url,
      body: "{}",
      headers: {
        ...HttpsService.defaultHeaders,
        'Authorization': 'Bearer ${HttpsService.accessToken}',
      },
    );

    return HttpsService.parseResponse(response);
  }
}
