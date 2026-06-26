import 'package:flutter/material.dart';

import '../layouts/main_layout.dart';

import '../services/dashboard_service.dart';
import '../services/storage_service.dart';

import 'login_screen.dart';

class StaffDashboard extends StatefulWidget {

  final String userName;

  const StaffDashboard({

    super.key,

    required this.userName,
  });

  @override
  State<StaffDashboard> createState() =>

      _StaffDashboardState();
}

class _StaffDashboardState
    extends State<StaffDashboard> {

  // ================= LOADING =================
  bool isLoading = true;

  // ================= DASHBOARD VALUES =================
  int totalTasks = 0;

  int completedTasks = 0;

  int pendingTasks = 0;

  int leaveBalance = 0;

  int attendance = 0;

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
            .getStaffDashboard();

    setState(() {

      totalTasks =
          data["total_tasks"] ?? 0;

      completedTasks =
          data["completed_tasks"] ?? 0;

      pendingTasks =
          data["pending_tasks"] ?? 0;

      leaveBalance =
          data["leave_balance"] ?? 0;

      attendance =
          data["attendance"] ?? 0;

      isLoading = false;
    });
  }

  // ================= MENU CLICK =================
  void onMenuTap(String title) {

    // ================= LOGOUT =================
    if(title == "Logout") {

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

      role: "employee",

      title: "Staff Dashboard",

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

                        // ================= TASKS =================
                        dashboardCard(
                          0,
                          "Total Tasks",
                          totalTasks.toString(),
                          Icons.task,
                          Colors.orange,
                        ),

                        // ================= COMPLETED =================
                        dashboardCard(
                          1,
                          "Completed",
                          completedTasks.toString(),
                          Icons.check_circle,
                          Colors.green,
                        ),

                        // ================= PENDING =================
                        dashboardCard(
                          2,
                          "Pending Tasks",
                          pendingTasks.toString(),
                          Icons.pending_actions,
                          Colors.red,
                        ),

                        // ================= LEAVE =================
                        dashboardCard(
                          3,
                          "Leave Balance",
                          leaveBalance.toString(),
                          Icons.note_alt,
                          Colors.blue,
                        ),

                        // ================= ATTENDANCE =================
                        dashboardCard(
                          4,
                          "Attendance",
                          attendance.toString(),
                          Icons.calendar_month,
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