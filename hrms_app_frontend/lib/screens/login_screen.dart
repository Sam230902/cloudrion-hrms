import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hrms_app_frontend/screens/admin_dashboard.dart';
import 'package:hrms_app_frontend/screens/forgot_password_screen.dart';
import 'package:hrms_app_frontend/screens/hr_dashboard.dart';
import 'package:hrms_app_frontend/screens/register_screen.dart';
import 'package:hrms_app_frontend/screens/staff_dashboard.dart';
import 'package:hrms_app_frontend/screens/super_admin_dashboard.dart';
import 'package:hrms_app_frontend/services/storage_service.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;
  bool _obscurePassword = true;

  // ================= LOGIN =================
  Future<void> login() async {
    EasyLoading.show(
      status: "Authenticating...",
    );
    final result = await AuthService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    EasyLoading.dismiss();
    if (result != null) {
      await StorageService.saveToken(
       result["access_token"],
      );

      await StorageService.saveName(
        result["name"] ?? "User",
      );

      await StorageService.saveRole(
        result["role"],
      );

      EasyLoading.showSuccess(
        "Welcome ${result["name"]}",
      );

      await Future.delayed(
        const Duration(milliseconds: 1200),
      );

      String role = result["role"];

      if (role == "Super Admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SuperAdminDashboard(
              userName: result["name"],
              role: result["role"],
            ),
          ),
        );
      }

      else if (role == "Admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AdminDashboard(
              userName: result["name"],
              role: role,
            ),
          ),
        );
      }

      else if (role == "HR Manager") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HrDashboard(
              userName: result["name"],
              role: role,
            ),
          ),
        );
      }

      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StaffDashboard(
              userName: result["name"],
            ),
         ),
        );
      }
    }
    else {
      EasyLoading.showError(
        "Invalid Email or Password",
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F5F5),

      body: Row(

        children: [

          // ================= LEFT SIDE =================
          Expanded(

            flex: 5,

            child: Container(

              color: Colors.orange,

              child: Padding(

                padding:
                    const EdgeInsets.all(
                  40,
                ),

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [

                    const Text(

                      "Welcome Back 👋",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 38,

                        fontWeight:
                            FontWeight.bold,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    const Text(

                      "Manage your HRMS, employees and operations in a smarter and faster way.",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 17,

                        color:
                            Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    Image.network(

                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",

                      height: 220,
                    ),

                    const SizedBox(
                      height: 35,
                    ),

                    Container(

                      padding:
                          const EdgeInsets
                              .all(18),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.orange
                                .shade300,

                        borderRadius:
                            BorderRadius
                                .circular(
                          18,
                        ),
                      ),

                      child:
                          const Column(

                        children: [

                          Text(

                            "All-in-One HRMS",

                            style:
                                TextStyle(

                              fontSize:
                                  22,

                              fontWeight:
                                  FontWeight
                                      .bold,

                              color:
                                  Colors
                                      .white,
                            ),
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Text(

                            "Track employees, attendance and manage your company easily.",

                            textAlign:
                                TextAlign
                                    .center,

                            style:
                                TextStyle(

                              color:
                                  Colors
                                      .white,

                              fontSize:
                                  15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ================= RIGHT SIDE =================
          Expanded(

            flex: 4,

            child: Center(

              child: Container(

                width: 400,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),

                  boxShadow: const [

                    BoxShadow(

                      blurRadius: 10,

                      color:
                          Colors.black12,
                    ),
                  ],
                ),

                child:
                    SingleChildScrollView(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      const Text(

                        "Login",

                        style: TextStyle(

                          fontSize: 34,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              Colors.orange,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // ================= EMAIL =================
                      const Text(

                        "Email",

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      TextField(

                        controller:
                            emailController,

                        decoration:
                            InputDecoration(

                          hintText:
                              "Enter your email",

                          contentPadding:
                              const EdgeInsets
                                  .symmetric(

                            horizontal: 14,

                            vertical: 14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      // ================= PASSWORD =================
                      const Text(

                        "Password",

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword =!_obscurePassword;
                              });
                            },
                          ),
                          contentPadding:const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ================= FORGOT PASSWORD =================
                      Align(

                        alignment:
                            Alignment
                                .centerRight,

                        child: TextButton(

                          onPressed: () {

                            Navigator.push(

                              context,

                              MaterialPageRoute(

                                builder: (_) =>
                                    const ForgotPasswordScreen(),
                              ),
                            );
                          },

                          child: const Text(

                            "Forgot Password?",

                            style: TextStyle(

                              color:
                                  Colors.orange,

                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // ================= LOGIN BUTTON =================
                      SizedBox(

                        width:
                            double.infinity,

                        height: 50,

                        child:
                            ElevatedButton(

                          style:
                              ElevatedButton
                                  .styleFrom(

                            backgroundColor:
                                Colors.orange,

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                          ),

                          onPressed:
                              loading
                                  ? null
                                  : login,

                          child: loading

                              ? const CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                )

                              : const Text(

                                  "Login",

                                  style:
                                      TextStyle(

                                    fontSize:
                                        18,

                                    color:
                                        Colors
                                            .white,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ================= REGISTER =================
                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [

                          const Text(

                            "Don't have an account? ",

                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          GestureDetector(

                            onTap: () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },

                            child: const Text(

                              "Register",

                              style: TextStyle(

                                color:
                                    Colors.orange,

                                fontWeight:
                                    FontWeight.bold,

                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}