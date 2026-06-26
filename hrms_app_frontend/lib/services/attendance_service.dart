import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendanceService {
  static const String baseUrl="http://127.0.0.1:8000/attendance";
  static Future checkIn({
    required String employeeId,
    required String date,
    required String checkInTime,
  }) async{
    final response=await http.post(
      Uri.parse(
        "$baseUrl/check-in"
      ),
      headers: {
        "Content-Type":"application/json",
      },
      body: jsonEncode({
        "employee_id":employeeId,
        "date":date,
        "check_in_time":checkInTime,
      }),
    );
    return jsonDecode(
      response.body,
    );
  }
  static Future checkOut({
    required String employeeId,
    required String date,
    required String checkOutTime,
  })async{
    final response=await http.put(
      Uri.parse(
        "$baseUrl/check-out",
      ),
      headers: {
        "Content-Type":"application/json",
      },
      body: jsonEncode({
        "employee_id":employeeId,
        "date":date,
        "check_out_time":checkOutTime,
      }),
    );
    return jsonEncode(
      response.body,
    );
  }
}
