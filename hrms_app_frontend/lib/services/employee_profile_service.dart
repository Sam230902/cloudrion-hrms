import 'dart:convert';
import 'package:http/http.dart' as http;

class EmployeeProfileService {

  // Change your backend URL
  static const String baseUrl =
      "http://127.0.0.1:8000";

  // ================= CREATE PROFILE =================

  static Future<bool> createProfile(
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          "$baseUrl/employee-profile/",
        ),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      print("STATUS = ${response.statusCode}");
      print("BODY = ${response.body}");
      return response.statusCode == 200 ||
        response.statusCode == 201;
    } catch (e) {
      print("Create Profile Error: $e");
      return false;
    }
  }
  // ================= GET PROFILE =================

  static Future<Map<String, dynamic>?>
      getProfile(
    String employeeId,
  ) async {

    try {

      final response = await http.get(

        Uri.parse(
          "$baseUrl/employee-profile/$employeeId",
        ),
      );

      if (response.statusCode == 200) {

        return jsonDecode(
          response.body,
        );
      }

      return null;

    } catch (e) {

      print(
        "Get Profile Error: $e",
      );

      return null;
    }
  }

  // ================= UPDATE PROFILE =================

  static Future<bool> updateProfile(

    String profileId,

    Map<String, dynamic> data,

  ) async {

    try {

      final response = await http.put(

        Uri.parse(
          "$baseUrl/employee-profile/$profileId",
        ),

        headers: {
          "Content-Type":
              "application/json",
        },

        body: jsonEncode(data),
      );

      return response.statusCode == 200;

    } catch (e) {

      print(
        "Update Profile Error: $e",
      );

      return false;
    }
  }

  // ================= DELETE PROFILE =================

  static Future<bool> deleteProfile(
    String profileId,
  ) async {

    try {

      final response = await http.delete(

        Uri.parse(
          "$baseUrl/employee-profile/$profileId",
        ),
      );

      return response.statusCode == 200;

    } catch (e) {

      print(
        "Delete Profile Error: $e",
      );

      return false;
    }
  }
}