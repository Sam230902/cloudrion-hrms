import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key,});

  @override
  State<RegisterScreen>createState() =>_RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController =TextEditingController();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();

  bool loading = false;

  bool obscurePassword = true;

  register() async {

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("All fields are required"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    final result =
        await AuthService.register(

      nameController.text,
      emailController.text,
      passwordController.text,
      "Employee",
    );

    setState(() {
      loading = false;
    });

    if (result != null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text("Registration Successful"),

          backgroundColor:
              Colors.green,
        ),
      );

      Future.delayed(

        const Duration(seconds: 2),

        () {

          Navigator.pushReplacement(

            context,

            MaterialPageRoute(

              builder: (_) =>
                  const LoginScreen(),
            ),
          );
        },
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
              Text("Registration Failed"),

          backgroundColor:
              Colors.red,
        ),
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

          // LEFT SIDE
          Expanded(

            flex: 5,

            child: Container(

              color: Colors.orange,

              child: Padding(

                padding:
                    const EdgeInsets.all(40),

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    const Text(

                      "Create Account 🚀",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 38,

                        fontWeight:
                            FontWeight.bold,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(

                      "Register and manage your HRMS system easily with modern employee management.",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(

                        fontSize: 17,

                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Image.network(

                      "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",

                      height: 220,
                    ),

                    const SizedBox(height: 35),

                    Container(

                      padding:
                          const EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        color:
                            Colors.orange.shade300,

                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),

                      child: const Column(

                        children: [

                          Text(

                            "HRMS Registration",

                            style: TextStyle(

                              fontSize: 22,

                              fontWeight:
                                  FontWeight.bold,

                              color: Colors.white,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(

                            "Create employee accounts and access HR management features securely.",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              color: Colors.white,

                              fontSize: 15,
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

          // RIGHT SIDE
          Expanded(

            flex: 4,

            child: Center(

              child: Container(

                width: 400,

                padding:
                    const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: const [

                    BoxShadow(

                      blurRadius: 10,

                      color: Colors.black12,
                    ),
                  ],
                ),

                child: SingleChildScrollView(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      const Text(

                        "Register",

                        style: TextStyle(

                          fontSize: 34,

                          fontWeight:
                              FontWeight.bold,

                          color: Colors.orange,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // FULL NAME
                      const Text(

                        "Full Name",

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(

                        controller:
                            nameController,

                        decoration:
                            InputDecoration(

                          hintText:
                              "Enter full name",

                          contentPadding:
                              const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // EMAIL
                      const Text(

                        "Email",

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(

                        controller:
                            emailController,

                        decoration:
                            InputDecoration(

                          hintText:
                              "Enter email",

                          contentPadding:
                              const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // PASSWORD
                      const Text(

                        "Password",

                        style: TextStyle(

                          fontSize: 15,

                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(

                        controller:
                            passwordController,

                        obscureText:
                            obscurePassword,

                        decoration:
                            InputDecoration(

                          hintText:
                              "Enter password",

                          suffixIcon:
                              IconButton(

                            icon: Icon(

                              obscurePassword

                                  ? Icons.visibility_off

                                  : Icons.visibility,
                            ),

                            onPressed: () {

                              setState(() {

                                obscurePassword =
                                    !obscurePassword;
                              });
                            },
                          ),

                          contentPadding:
                              const EdgeInsets.symmetric(

                            horizontal: 14,

                            vertical: 14,
                          ),

                          border:
                              OutlineInputBorder(

                            borderRadius:
                                BorderRadius.circular(
                              12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // REGISTER BUTTON
                      SizedBox(

                        width: double.infinity,

                        height: 50,

                        child: ElevatedButton(

                          style:
                              ElevatedButton.styleFrom(

                            backgroundColor:
                                Colors.orange,

                            shape:
                                RoundedRectangleBorder(

                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),

                          onPressed:
                              loading
                                  ? null
                                  : register,

                          child: loading

                              ? const CircularProgressIndicator(
                                  color:
                                      Colors.white,
                                )

                              : const Text(

                                  "Register",

                                  style: TextStyle(

                                    fontSize: 18,

                                    color:
                                        Colors.white,

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // LOGIN
                      Row(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          const Text(

                            "Already have an account? ",

                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          GestureDetector(

                            onTap: () {

                              Navigator.pushReplacement(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      const LoginScreen(),
                                ),
                              );
                            },

                            child: const Text(

                              "Login",

                              style: TextStyle(

                                color: Colors.orange,

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