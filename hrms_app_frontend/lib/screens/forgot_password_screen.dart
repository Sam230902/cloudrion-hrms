import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key,});

  @override
  State<ForgotPasswordScreen>createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final emailController =TextEditingController();

  bool loading = false;

  resetPassword() async {

    setState(() {
      loading = true;
    });

    await Future.delayed(
      const Duration(seconds: 2),
    );

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content: Text(
          "Password reset link sent to email",
        ),

        backgroundColor:
            Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F7FB),

      appBar: AppBar(

        backgroundColor:
            Colors.orange,

        title: const Text(
          "Forgot Password",
        ),
      ),

      body: Center(

        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Container(

            width: 400,

            padding:
                const EdgeInsets.all(25),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(
                20,
              ),

              boxShadow: const [

                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),

            child: Column(

              mainAxisSize:
                  MainAxisSize.min,

              children: [

                const Icon(

                  Icons.lock_reset,

                  size: 80,

                  color: Colors.orange,
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(

                  "Forgot Password?",

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight:
                        FontWeight.bold,

                    color: Colors.orange,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                const Text(

                  "Enter your registered email address to receive password reset instructions.",

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(

                    color: Colors.grey,

                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                TextField(

                  controller:
                      emailController,

                  keyboardType:
                      TextInputType
                          .emailAddress,

                  decoration:
                      InputDecoration(

                    labelText:
                        "Email Address",

                    hintText:
                        "Enter your email",

                    prefixIcon:
                        const Icon(
                      Icons.email,
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

                const SizedBox(
                  height: 25,
                ),

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
                            BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),

                    onPressed:
                        loading
                            ? null
                            : resetPassword,

                    child: loading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : const Text(

                            "Send Reset Link",

                            style:
                                TextStyle(

                              color:
                                  Colors.white,

                              fontSize:
                                  17,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                TextButton(

                  onPressed: () {

                    Navigator.pop(
                      context,
                    );
                  },

                  child: const Text(

                    "Back to Login",

                    style: TextStyle(
                      color:
                          Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}