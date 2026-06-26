import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {

  // ================= BASE URL =================
  static const String baseUrl =
      "http://127.0.0.1:8000/dashboard";

  // ================= SUPER ADMIN =================
  static Future<Map<String, dynamic>>
      getSuperAdminDashboard() async {

    try {

      final response = await http.get(

        Uri.parse(
          "$baseUrl/super-admin",
        ),
      );

      if(response.statusCode == 200) {

        return jsonDecode(
          response.body,
        );
      }

      return {};

    } catch (e) {

      return {};
    }
  }

  // ================= ADMIN =================
  static Future<Map<String, dynamic>>
      getAdminDashboard() async {

    try {

      final response = await http.get(

        Uri.parse(
          "$baseUrl/admin",
        ),
      );

      if(response.statusCode == 200) {

        return jsonDecode(
          response.body,
        );
      }

      return {};

    } catch (e) {

      return {};
    }
  }

  // ================= HR =================
  static Future<Map<String, dynamic>>
      getHRDashboard() async {

    try {

      final response = await http.get(

        Uri.parse(
          "$baseUrl/hr",
        ),
      );

      if(response.statusCode == 200) {

        return jsonDecode(
          response.body,
        );
      }

      return {};

    } catch (e) {

      return {};
    }
  }

  // ================= STAFF =================
  static Future<Map<String, dynamic>>
      getStaffDashboard() async {

    try {

      final response = await http.get(

        Uri.parse(
          "$baseUrl/staff",
        ),
      );

      if(response.statusCode == 200) {

        return jsonDecode(
          response.body,
        );
      }

      return {};

    } catch (e) {

      return {};
    }
  }
}