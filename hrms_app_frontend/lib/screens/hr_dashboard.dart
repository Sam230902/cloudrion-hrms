import 'package:flutter/material.dart';

import '../layouts/main_layout.dart';

import '../services/dashboard_service.dart';
import '../services/storage_service.dart';

import 'employee_screen.dart';
import 'login_screen.dart';
import 'users_screen.dart';

class HrDashboard extends StatefulWidget {

  final String userName;
  final String role;

  const HrDashboard({

    super.key,

    required this.userName,
    required this.role,
  });

  @override
  State<HrDashboard> createState() =>

      _HrDashboardState();
}

class _HrDashboardState
    extends State<HrDashboard> {

  // ================= LOADING =================
  bool isLoading = true;

  // ================= DASHBOARD VALUES =================
  int totalEmployees = 0;

  int todayAttendance = 0;

  int leaveRequests = 0;

  int pendingApprovals = 0;

  // ================= HOVER =================
  int hoveredIndex = -1;

  // ================= INIT =================
  @override
  void initState() {

    super.initState();

    loadDashboard();
  }

  // ================= LOAD DASHBOARD =================
  Future<void> loadDashboard() async {

    final data =
        await DashboardService
            .getHRDashboard();

    setState(() {

      totalEmployees =
          data["total_employees"] ?? 0;

      todayAttendance =
          data["today_attendance"] ?? 0;

      leaveRequests =
          data["leave_requests"] ?? 0;

      pendingApprovals =
          data["pending_approvals"] ?? 0;

      isLoading = false;
    });
  }

  // ================= MENU CLICK =================
  void onMenuTap(String title) {

    // ================= EMPLOYEES =================
    if(title == "Employees") {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              EmployeeScreen(
                userName: widget.userName,
                  role: "hr manager",
              ),
        ),
      );
    }

    // ================= USERS =================
    else if(title == "Users") {

      Navigator.push(

        context,

        MaterialPageRoute(

          builder: (_) =>
              UsersScreen(
            userName:
                widget.userName,
            role: widget.role,
          ),
        ),
      );
    }

    // ================= LOGOUT =================
    else if(title == "Logout") {

      logout();
    }
  }

  // ================= LOGOUT =================
  Future<void> logout() async {

    await StorageService.logout();

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(

        builder: (_) =>
            const LoginScreen(),
      ),

      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(

      role: "hr",

      title: "HR Dashboard",

      userName: widget.userName,

      onLogout: logout,

      onMenuTap: onMenuTap,

      child:

          isLoading

              ? const Center(

                  child:
                      CircularProgressIndicator(),
                )

              : RefreshIndicator(

                  onRefresh:
                      loadDashboard,

                  child:
                      SingleChildScrollView(

                    physics:
                        const AlwaysScrollableScrollPhysics(),

                    padding:
                        const EdgeInsets.all(
                      25,
                    ),

                    child: Wrap(

                      spacing: 20,

                      runSpacing: 20,

                      children: [

                        // ================= EMPLOYEES =================
                        dashboardCard(
                          0,
                          "Employees",
                          totalEmployees
                              .toString(),
                          Icons.people,
                          Colors.orange,
                        ),

                        // ================= ATTENDANCE =================
                        dashboardCard(
                          1,
                          "Attendance",
                          todayAttendance
                              .toString(),
                          Icons.calendar_month,
                          Colors.green,
                        ),

                        // ================= LEAVE =================
                        dashboardCard(
                          2,
                          "Leave Requests",
                          leaveRequests
                              .toString(),
                          Icons.note_alt,
                          Colors.red,
                        ),

                        // ================= APPROVALS =================
                        dashboardCard(
                          3,
                          "Pending Approvals",
                          pendingApprovals
                              .toString(),
                          Icons.pending_actions,
                          Colors.purple,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  // ================= CARD =================
  Widget dashboardCard(

    int index,

    String title,

    String value,

    IconData icon,

    Color color,
  ) {

    bool isHovered =
        hoveredIndex == index;

    return MouseRegion(

      cursor:
          SystemMouseCursors.click,

      onEnter: (_) {

        setState(() {

          hoveredIndex = index;
        });
      },

      onExit: (_) {

        setState(() {

          hoveredIndex = -1;
        });
      },

      child: AnimatedScale(

        scale:
            isHovered ? 1.03 : 1,

        duration:
            const Duration(
          milliseconds: 200,
        ),

        child: AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 250,
          ),

          width: 260,

          padding:
              const EdgeInsets.all(
            20,
          ),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              20,
            ),

            boxShadow: [

              BoxShadow(

                color:
                    isHovered

                        ? color.withOpacity(
                            0.18,
                          )

                        : Colors.black
                            .withOpacity(
                            0.05,
                          ),

                blurRadius:
                    isHovered ? 18 : 10,

                offset:
                    const Offset(0, 6),
              ),
            ],
          ),

          child: Row(

            mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,

            children: [

              Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(

                    title,

                    style:
                        const TextStyle(

                      color: Colors.grey,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(

                    value,

                    style:
                        const TextStyle(

                      fontSize: 30,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Container(

                padding:
                    const EdgeInsets.all(
                  15,
                ),

                decoration:
                    BoxDecoration(

                  color:
                      color.withOpacity(
                    0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),

                child: Icon(

                  icon,

                  color: color,

                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}