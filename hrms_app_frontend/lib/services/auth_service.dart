import 'dart:convert';
import 'package:http/http.dart'as http;

class AuthService {

  static const String baseUrl =
      "http://127.0.0.1:8000";

  // LOGIN
  static Future<Map<String, dynamic>?> login(

    String email,
    String password,

  ) async {

    try {

      final response =
          await http.post(
        Uri.parse(
          "$baseUrl/auth/login",
        ),

        headers: {

          "Content-Type":"application/json",
        },

        body: jsonEncode({

          "email": email,
          "password": password,
        }),
      );

      print(response.body);

      if(response.statusCode == 200){

        return jsonDecode(
          response.body,
        );
      }

      return null;

    } catch (e) {

      print(e);

      return null;
    }
  }

  // REGISTER
  static Future<Map<String, dynamic>?> register(

    String firstName,
    String email,
    String password,
    String role,

  ) async {

    try {

      final response =
          await http.post(

        Uri.parse(
          "$baseUrl/employees/",
        ),

        headers: {

          "Content-Type":"application/json",
        },

        body: jsonEncode({

          "employee_code":DateTime.now().microsecondsSinceEpoch.toString(),
          "first_name":firstName,
          "last_name": "",
          "email": email,
          "phone":"9999999999",
          "password":password,
          "role": role,
          "manager_id": "",
          "department":"HR",
          "designation":role,
          "joining_date":DateTime.now().toString().split(" ")[0],
        }),
      );

      print(response.body);

      if(response.statusCode == 200){

        return {"success": true,};
      }

      return null;

    } catch (e) {

      print(e);

      return null;
    }
  }
}