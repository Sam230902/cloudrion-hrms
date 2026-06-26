import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {

  final String role;

  final Function(String) onMenuTap;

  const Sidebar({

    super.key,

    required this.role,

    required this.onMenuTap,
  });

  @override
  State<Sidebar> createState() =>
      _SidebarState();
}

class _SidebarState
    extends State<Sidebar> {

  String selectedMenu =
      "Dashboard";

  String hoveredMenu = "";

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> menus = [];

    // ================= SUPER ADMIN =================
    if (widget.role ==
        "super_admin") {

      menus = [

        {
          "title": "Dashboard",
          "icon": Icons.dashboard,
        },

        {
          "title": "Employees",
          "icon": Icons.people,
        },

        {
          "title": "Attendance",
          "icon": Icons.calendar_month,
        },

        {
          "title": "Leave",
          "icon": Icons.note_alt,
        },

        {
          "title": "Payroll",
          "icon": Icons.currency_rupee,
        },

        {
          "title": "Reports",
          "icon": Icons.bar_chart,
        },

        {
          "title": "Users",
          "icon": Icons.person,
        },

        {
          "title": "Logout",
          "icon": Icons.logout,
        },
      ];
    }

    // ================= ADMIN =================
    else if (widget.role ==
        "admin") {

      menus = [

        {
          "title": "Dashboard",
          "icon": Icons.dashboard,
        },

        {
          "title": "Employees",
          "icon": Icons.people,
        },

        {
          "title": "Attendance",
          "icon": Icons.calendar_month,
        },

        {
          "title": "Leave",
          "icon": Icons.note_alt,
        },

        {
          "title": "Payroll",
          "icon": Icons.currency_rupee,
        },

        {
          "title": "Reports",
          "icon": Icons.bar_chart,
        },

        {
          "title": "Users",
          "icon": Icons.person,
        },

        {
          "title": "Logout",
          "icon": Icons.logout,
        },
      ];
    }

    // ================= HR =================
    else if (widget.role ==
        "hr") {

      menus = [

        {
          "title": "Dashboard",
          "icon": Icons.dashboard,
        },

        {
          "title": "Employees",
          "icon": Icons.people,
        },

        {
          "title": "Attendance",
          "icon": Icons.calendar_month,
        },

        {
          "title": "Recruitment",
          "icon": Icons.badge,
        },

        {
          "title": "Leave",
          "icon": Icons.note_alt,
        },

        {
          "title": "Reports",
          "icon": Icons.bar_chart,
        },

        {
          "title": "Users",
          "icon": Icons.person,
        },

        {
          "title": "Logout",
          "icon": Icons.logout,
        },
      ];
    }

    // ================= EMPLOYEE =================
    else {

      menus = [

        {
          "title": "Dashboard",
          "icon": Icons.dashboard,
        },

        {
          "title": "Attendance",
          "icon": Icons.calendar_month,
        },

        {
          "title": "Profile",
          "icon": Icons.person,
        },

        {
          "title": "Leave",
          "icon": Icons.note_alt,
        },

        {
          "title": "Logout",
          "icon": Icons.logout,
        },
      ];
    }

    return MouseRegion(

      onEnter: (_) {

        setState(() {

          isExpanded = true;
        });
      },

      onExit: (_) {

        setState(() {

          isExpanded = false;
        });
      },

      child: AnimatedContainer(

        duration:
            const Duration(
          milliseconds: 300,
        ),

        width:
            isExpanded ? 250 : 95,

        decoration:
            const BoxDecoration(

          color: Colors.white,

          boxShadow: [

            BoxShadow(

              color: Colors.black12,

              blurRadius: 8,
            ),
          ],
        ),

        child: Column(

          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding:
                const EdgeInsets.all(10,),
                child: Center(
                  child: Image.asset(
                    "assets/images/sme_logo.png",
                    height:
                      isExpanded
                        ? 95
                        : 55,
                      fit: BoxFit.contain,
                  ),
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.shade300,
            ),

            

            // ================= MENU =================
            Expanded(

              child: ListView.builder(

                padding:
                    const EdgeInsets.all(
                  12,
                ),

                itemCount:
                    menus.length,

                itemBuilder:
                    (context, index) {

                  final menu =
                      menus[index];

                  bool isSelected =

                      selectedMenu ==
                          menu["title"];

                  bool isHovered =

                      hoveredMenu ==
                          menu["title"];

                  return Padding(

                    padding:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: MouseRegion(

                      cursor:
                          SystemMouseCursors.click,

                      onEnter: (_) {

                        setState(() {

                          hoveredMenu =
                              menu["title"];
                        });
                      },

                      onExit: (_) {

                        setState(() {

                          hoveredMenu = "";
                        });
                      },

                      child: InkWell(

                        borderRadius:
                            BorderRadius.circular(
                          16,
                        ),

                        onTap: () {

                          setState(() {

                            selectedMenu =
                                menu["title"];
                          });

                          widget.onMenuTap(
                            menu["title"],
                          );
                        },

                        child:
                            AnimatedScale(

                          scale:
                              isHovered
                                  ? 1.02
                                  : 1,

                          duration:
                              const Duration(
                            milliseconds: 180,
                          ),

                          child:
                              AnimatedContainer(

                            duration:
                                const Duration(
                              milliseconds: 250,
                            ),
                            
                            padding: EdgeInsets.symmetric(
                              horizontal: isExpanded ? 15 : 8,
                              vertical: 15,
                            ),

                            decoration:
                                BoxDecoration(

                              color: isSelected

                                  ? Colors.orange
                                      .shade50

                                  : isHovered

                                      ? Colors.orange
                                          .shade100

                                      : Colors.transparent,

                              borderRadius:
                                  BorderRadius.circular(
                                16,
                              ),

                              border: isSelected

                                  ? Border.all(
                                      color:
                                          Colors.orange,
                                      width: 1,
                                    )

                                  : null,
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [

                                Icon(

                                  menu["icon"],

                                  color:
                                      isSelected

                                          ? Colors.orange

                                          : isHovered

                                              ? Colors.orange

                                              : Colors.grey
                                                  .shade700,

                                  size: 24,
                                ),

                                if (isExpanded)
                                  ...[

                                    const SizedBox(
                                      width: 15,
                                    ),

                                    Expanded(

                                      child: Text(

                                        menu["title"],

                                        style:
                                            TextStyle(

                                          fontSize: 15,

                                          fontWeight:
                                              isSelected

                                                  ? FontWeight.bold

                                                  : FontWeight.w500,

                                          color:
                                              isSelected

                                                  ? Colors.orange

                                                  : isHovered

                                                      ? Colors.orange

                                                      : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ================= FOOTER =================
            if (isExpanded)

              Padding(

                padding:
                    const EdgeInsets.all(
                  18,
                ),

                child: Column(

                  children: [

                    Divider(
                      color:
                          Colors.grey.shade300,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(

                      "HRMS Management System",

                      style: TextStyle(

                        fontSize: 13,

                        color:
                            Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(

                      "Version 1.0.0",

                      style: TextStyle(

                        fontSize: 12,

                        color:
                            Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}