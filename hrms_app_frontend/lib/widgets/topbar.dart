import 'package:flutter/material.dart';

class Topbar extends StatefulWidget {

  final String role;

  final String title;

  final String userName;

  final VoidCallback onLogout;

  const Topbar({

    super.key,

    required this.role,

    required this.title,

    required this.userName,

    required this.onLogout,
  });

  @override
  State<Topbar> createState() =>
      _TopbarState();
}

class _TopbarState
    extends State<Topbar> {

  bool showProfileMenu = false;

  @override
  Widget build(BuildContext context) {

    return Container(

      height: 85,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 30,
      ),

      decoration:
          const BoxDecoration(

        color: Colors.white,

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          // ================= TITLE =================
          Text(

            widget.title,

            style:
                const TextStyle(

              fontSize: 28,

              fontWeight:
                  FontWeight.bold,

              color: Colors.black87,
            ),
          ),

          // ================= RIGHT SIDE =================
          Row(

            children: [

              // ================= MAIL =================
              topIcon(
                Icons.mail_outline,
              ),

              const SizedBox(
                width: 15,
              ),

              // ================= NOTIFICATION =================
              Stack(

                children: [

                  topIcon(
                    Icons.notifications_none,
                  ),

                  Positioned(

                    right: 0,
                    top: 0,

                    child: Container(

                      padding:
                          const EdgeInsets.all(
                        5,
                      ),

                      decoration:
                          const BoxDecoration(

                        color: Colors.red,

                        shape:
                            BoxShape.circle,
                      ),

                      child: const Text(

                        "5",

                        style: TextStyle(

                          color:
                              Colors.white,

                          fontSize: 10,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                width: 25,
              ),

              // ================= PROFILE =================
              Stack(

                clipBehavior: Clip.none,

                children: [

                  InkWell(

                    onTap: () {

                      setState(() {

                        showProfileMenu =
                            !showProfileMenu;
                      });
                    },

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),

                    child: Row(

                      children: [

                        CircleAvatar(

                          radius: 22,

                          backgroundColor:
                              Colors.orange
                                  .shade100,

                          child: Text(

                            widget.userName[0]
                                .toUpperCase(),

                            style:
                                const TextStyle(

                              color:
                                  Colors.orange,

                              fontWeight:
                                  FontWeight.bold,

                              fontSize: 18,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 12,
                        ),

                        Column(

                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            Text(

                              widget.userName,

                              style:
                                  const TextStyle(

                                fontSize: 16,

                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),

                            Text(

                              widget.role
                                  .toUpperCase(),

                              style:
                                  TextStyle(

                                fontSize: 12,

                                color: Colors
                                    .grey
                                    .shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // ================= PROFILE SETTINGS =================
                  if (showProfileMenu)

                    Positioned(

                      top: 65,

                      right: 0,

                      child: Material(

                        elevation: 8,

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),

                        child: Container(

                          width: 190,

                          padding:
                              const EdgeInsets.symmetric(
                            vertical: 6,
                          ),

                          decoration:
                              BoxDecoration(

                            color: Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),

                          child: Column(

                            mainAxisSize:
                                MainAxisSize.min,

                            children: [

                              InkWell(

                                onTap: () {

                                  setState(() {

                                    showProfileMenu =
                                        false;
                                  });

                                  // Navigate profile settings
                                },

                                child: Container(

                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),

                                  child: const Row(

                                    children: [

                                      Icon(
                                        Icons.settings_outlined,
                                        size: 22,
                                      ),

                                      SizedBox(
                                        width: 14,
                                      ),

                                      Text(

                                        "Profile Settings",

                                        style:
                                            TextStyle(

                                          fontSize: 15,

                                          fontWeight:
                                              FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(
                width: 20,
              ),

              // ================= LOGOUT BUTTON =================
              InkWell(

                onTap: widget.onLogout,

                borderRadius:
                    BorderRadius.circular(
                  50,
                ),

                child: Container(

                  padding:
                      const EdgeInsets.all(
                    12,
                  ),

                  decoration: BoxDecoration(

                    color:
                        Colors.red.shade50,

                    shape: BoxShape.circle,
                  ),

                  child: Icon(

                    Icons.logout,

                    color:
                        Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ICON =================
  Widget topIcon(
    IconData icon,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(10),

      decoration: BoxDecoration(

        color:
            Colors.orange.shade50,

        shape: BoxShape.circle,
      ),

      child: Icon(

        icon,

        color: Colors.orange,
      ),
    );
  }
}