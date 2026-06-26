import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  // ================= SAVE TOKEN =================
  static Future saveToken(
    String token,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "token",
      token,
    );
  }

  // ================= GET TOKEN =================
  static Future<String?>
      getToken() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      "token",
    );
  }

  // ================= SAVE NAME =================
  static Future saveName(
    String name,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "name",
      name,
    );
  }

  // ================= GET NAME =================
  static Future<String?>
      getName() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      "name",
    );
  }

  // ================= SAVE ROLE =================
  static Future saveRole(
    String role,
  ) async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.setString(
      "role",
      role,
    );
  }

  // ================= GET ROLE =================
  static Future<String?>
      getRole() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    return prefs.getString(
      "role",
    );
  }

  // ================= LOGOUT =================
  static Future logout() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();
  }

  // ================= CLEAR STORAGE =================
  static Future clearStorage() async {

    final prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();
  }
}