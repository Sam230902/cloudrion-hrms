import 'dart:convert';

import 'package:http/http.dart'
    as http;

class ProfileService {

  static const String baseUrl =
      "http://127.0.0.1:8000";

  // ================= CREATE =================
  static Future createPersonalInfo({

    required String employeeId,

    required String firstName,

    required String lastName,

    required String dob,

    required String bloodGroup,

    required String gender,

    required String nationality,

    required String panNumber,

    required String address,

  }) async {

    final response = await http.post(

      Uri.parse(
        "$baseUrl/personal-info/",
      ),

      headers: {

        "Content-Type":
            "application/json",
      },

      body: jsonEncode({

        "employee_id":
            employeeId,

        "first_name":
            firstName,

        "middle_name":
            "",

        "last_name":
            lastName,

        "date_of_birth":
            dob,

        "blood_group":
            bloodGroup,

        "gender":
            gender,

        "marital_status":
            "Single",

        "religion":
            "Hindu",

        "nationality":
            nationality,

        "native_state":
            "Tamil Nadu",

        "pan_number":
            panNumber,

        "passport_number":
            "",

        "permanent_address":
            address,

        "pincode":
            "641402",
      }),
    );

    return jsonDecode(
      response.body,
    );
  }

  // ================= GET =================
  static Future<Map<String,dynamic>>
      getPersonalInfo(
    String employeeId,
  ) async {

    final response = await http.get(

      Uri.parse(
        "$baseUrl/personal-info/$employeeId",
      ),
    );

    if(response.statusCode == 200){

      return jsonDecode(
        response.body,
      );
    }

    return {};
  }
}