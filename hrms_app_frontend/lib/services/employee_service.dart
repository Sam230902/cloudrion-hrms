import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EmployeeService {

  static const String baseUrl =
      "http://127.0.0.1:8000/employees/";

  // ================= GET EMPLOYEES =================

  static Future<List> getEmployees() async {

    try {

      final response = await http.get(
        Uri.parse(baseUrl),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      return [];

    } catch (e) {

      print("GET EMPLOYEE ERROR => $e");
      return [];
    }
  }

  // ================= CREATE EMPLOYEE =================

  static Future<Map<String, dynamic>> addEmployee(
    Map<String, String> data,
    File? image,
    Uint8List? webImage,
  ) async {

    try {

      var request = http.MultipartRequest(
        "POST",
        Uri.parse(baseUrl),
      );

      request.fields.addAll(data);

      if (kIsWeb && webImage != null) {

        request.files.add(
          http.MultipartFile.fromBytes(
            "profile_image",
            webImage,
            filename: "profile.jpg",
          ),
        );
      }

      else if (image != null) {

        request.files.add(
          await http.MultipartFile.fromPath(
            "profile_image",
            image.path,
          ),
        );
      }

      var response = await request.send();

      final body =
          await response.stream.bytesToString();

      print("CREATE STATUS => ${response.statusCode}");
      print("CREATE BODY => $body");

      String message = "Something went wrong";

      try {

        final jsonBody =
            jsonDecode(body);

        message =
            jsonBody["detail"] ??
            jsonBody["message"] ??
            "Something went wrong";

      } catch (_) {}

      return {

        "success":
            response.statusCode == 200 ||
            response.statusCode == 201,

        "message": message,
      };

    } catch (e) {

      print("CREATE ERROR => $e");

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

  // ================= DELETE EMPLOYEE =================

  static Future<bool> deleteEmployee(
    String id,
  ) async {

    try {

      final response = await http.delete(
        Uri.parse("$baseUrl$id"),
      );

      print("DELETE STATUS => ${response.statusCode}");

      return response.statusCode == 200;

    } catch (e) {

      print("DELETE ERROR => $e");
      return false;
    }
  }

  // ================= UPDATE EMPLOYEE =================

  static Future<Map<String, dynamic>> updateEmployee(
    String id,
    Map<String, dynamic> data,
  ) async {

    try {

      final response = await http.put(
        Uri.parse("$baseUrl$id"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      print("UPDATE STATUS => ${response.statusCode}");
      print("UPDATE BODY => ${response.body}");

      String message = "Something went wrong";

      try {

        final jsonBody =
            jsonDecode(response.body);

        message =
            jsonBody["detail"] ??
            jsonBody["message"] ??
            "Something went wrong";

      } catch (_) {}

      return {

        "success":
            response.statusCode == 200,

        "message": message,
      };

    } catch (e) {

      print("UPDATE ERROR => $e");

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }
}