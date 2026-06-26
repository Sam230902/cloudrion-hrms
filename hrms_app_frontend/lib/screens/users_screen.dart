import 'package:flutter/material.dart';
import '../services/employee_service.dart';
import 'create_employee_screen.dart';

class UsersScreen extends StatefulWidget {

  final String userName;
  final String role;


  const UsersScreen({
    super.key,
    required this.userName,
    required this.role
  });

  @override
  State<UsersScreen> createState() =>
      _UsersScreenState();
}

class _UsersScreenState
    extends State<UsersScreen> {

  List users = [];

  List filteredUsers = [];

  bool loading = true;

  bool isSidebarHover = false;

  final TextEditingController
      searchController =
          TextEditingController();

  @override
  void initState() {

    super.initState();

    loadUsers();
  }

  // ================= LOAD USERS =================

  void loadUsers() async {

    setState(() {
      loading = true;
    });

    final data =
        await EmployeeService
            .getEmployees();

    setState(() {

      users = data;

      filteredUsers = data;

      loading = false;
    });
  }

  // ================= SEARCH =================

  void searchUser(String value) {

    setState(() {

      filteredUsers =
          users.where((user) {

        final name =
            "${user['first_name']} ${user['last_name']}"
                .toLowerCase();

        final dept =
            (user['department'] ?? "")
                .toString()
                .toLowerCase();

        final desig =
            (user['designation'] ?? "")
                .toString()
                .toLowerCase();

        return name.contains(
                  value.toLowerCase(),
                ) ||
            dept.contains(
              value.toLowerCase(),
            ) ||
            desig.contains(
              value.toLowerCase(),
            );
      }).toList();
    });
  }

  // ================= DELETE =================

  void deleteUser(String id) async {

    await EmployeeService
        .deleteEmployee(id);

    loadUsers();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F7FB),

      body: Row(
        children: [

          // ================= SIDEBAR =================

          MouseRegion(

            onEnter: (_) {

              setState(() {

                isSidebarHover = true;
              });
            },

            onExit: (_) {

              setState(() {

                isSidebarHover = false;
              });
            },

            child: AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 300,
              ),

              width:
                  isSidebarHover
                      ? 240
                      : 90,

              decoration:
                  const BoxDecoration(

                color: Colors.white,

                boxShadow: [

                  BoxShadow(
                    color:
                        Colors.black12,
                    blurRadius: 5,
                  ),
                ],
              ),

              child: Column(
                children: [

                  const SizedBox(
                    height: 20,
                  ),

                  // ================= LOGO =================

                  Container(

                    width:
                        isSidebarHover
                            ? 170
                            : 65,

                    height:
                        isSidebarHover
                            ? 90
                            : 65,

                    padding:
                        const EdgeInsets.all(
                      8,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.orange
                              .shade50,

                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),
                    ),

                    child: Image.asset(
                      "assets/images/sme_logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Expanded(

                    child: Column(
                      children: [

                        buildMenu(
                          Icons.dashboard,
                          "Dashboard",
                        ),

                        buildMenu(
                          Icons.people,
                          "Employees",
                        ),

                        buildMenu(
                          Icons.person_add,
                          "Create User",
                        ),

                        buildMenu(
                          Icons.calendar_month,
                          "Attendance",
                        ),

                        buildMenu(
                          Icons.note_alt,
                          "Leave",
                        ),

                        buildMenu(
                          Icons.currency_rupee,
                          "Payroll",
                        ),

                        buildMenu(
                          Icons.bar_chart,
                          "Reports",
                        ),

                        buildMenu(
                          Icons.settings,
                          "Settings",
                        ),
                      ],
                    ),
                  ),

                  Padding(

                    padding:
                        const EdgeInsets.only(
                      bottom: 20,
                    ),

                    child: buildMenu(
                      Icons.logout,
                      "Logout",
                    ),
                  )
                ],
              ),
            ),
          ),

          // ================= RIGHT SIDE =================

          Expanded(

            child: Column(
              children: [

                // ================= TOPBAR =================

                Container(

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
                        color:
                            Colors.black12,
                        blurRadius: 5,
                      ),
                    ],
                  ),

                  child: Row(

                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [

                      const Text(

                        "Users Management",

                        style: TextStyle(

                          fontSize: 28,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: [

                          topIcon(
                            Icons.mail_outline,
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          topIcon(
                            Icons.notifications_none,
                          ),

                          const SizedBox(
                            width: 20,
                          ),

                          const CircleAvatar(
                            radius: 22,
                            backgroundImage:
                                AssetImage(
                              "assets/images/profile.jpg",
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Text(

                            widget.userName,

                            style:
                                const TextStyle(

                              fontSize: 18,

                              fontWeight:
                                  FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // ================= CONTENT =================

                Expanded(

                  child:
                      SingleChildScrollView(

                    padding:
                        const EdgeInsets.all(
                      20,
                    ),

                    child: Column(
                      children: [

                        // ================= TOP ACTIONS =================

                        Row(

                          children: [

                            Expanded(

                              child: TextField(

                                controller:
                                    searchController,

                                onChanged:
                                    searchUser,

                                decoration:
                                    InputDecoration(

                                  hintText:
                                      "Search user...",

                                  prefixIcon:
                                      const Icon(
                                    Icons.search,
                                  ),

                                  filled: true,

                                  fillColor:
                                      Colors.white,

                                  border:
                                      OutlineInputBorder(

                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),

                                    borderSide:
                                        BorderSide.none,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            ElevatedButton.icon(

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    Colors.orange,

                                padding:
                                    const EdgeInsets.symmetric(

                                  horizontal: 20,

                                  vertical: 18,
                                ),
                              ),

                              onPressed: () async {

                                await Navigator.push(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                        CreateEmployeeScreen(
                                      userName: widget.userName,
                                      role: widget.role,
                                    ),
                                  ),
                                );

                                loadUsers();
                              },

                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),

                              label: const Text(

                                "Add User",

                                style: TextStyle(
                                  color:
                                      Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // ================= USER LIST =================

                        loading

                            ? const Center(
                                child:
                                    CircularProgressIndicator(),
                              )

                            : filteredUsers
                                    .isEmpty

                                ? const Center(
                                    child: Padding(

                                      padding:
                                          EdgeInsets.all(
                                        50,
                                      ),

                                      child: Text(
                                        "No Users Found",
                                      ),
                                    ),
                                  )

                                : ListView.builder(

                                    shrinkWrap:
                                        true,

                                    physics:
                                        const NeverScrollableScrollPhysics(),

                                    itemCount:
                                        filteredUsers
                                            .length,

                                    itemBuilder:
                                        (
                                          context,
                                          index,
                                        ) {

                                      final user =
                                          filteredUsers[
                                              index];

                                      return Container(

                                        margin:
                                            const EdgeInsets.only(
                                          bottom:
                                              15,
                                        ),

                                        padding:
                                            const EdgeInsets.all(
                                          15,
                                        ),

                                        decoration:
                                            BoxDecoration(

                                          color:
                                              Colors.white,

                                          borderRadius:
                                              BorderRadius.circular(
                                            15,
                                          ),
                                        ),

                                        child: Row(
                                          children: [

                                            // ================= AVATAR =================

                                            CircleAvatar(

                                              radius:
                                                  28,

                                              backgroundColor:
                                                  Colors.orange,

                                              child:
                                                  Text(

                                                user['first_name'] !=
                                                        null
                                                    ? user['first_name'][0]
                                                        .toUpperCase()
                                                    : "U",

                                                style:
                                                    const TextStyle(

                                                  color:
                                                      Colors.white,

                                                  fontWeight:
                                                      FontWeight.bold,

                                                  fontSize:
                                                      20,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              width:
                                                  20,
                                            ),

                                            // ================= DETAILS =================

                                            Expanded(

                                              child:
                                                  Column(

                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,

                                                children: [

                                                  Text(

                                                    "${user['first_name']} ${user['last_name']}",

                                                    style:
                                                        const TextStyle(

                                                      fontSize:
                                                          18,

                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),

                                                  const SizedBox(
                                                    height:
                                                        5,
                                                  ),

                                                  Text(
                                                    user['designation'] ??
                                                        "",
                                                  ),

                                                  Text(
                                                    user['department'] ??
                                                        "",
                                                  ),

                                                  Text(

                                                    user['employee_code'] ??
                                                        "",

                                                    style:
                                                        const TextStyle(

                                                      color:
                                                          Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),

                                            // ================= ACTIONS =================

                                            Row(
                                              children: [

                                                IconButton(

                                                  onPressed:
                                                      () {},

                                                  icon:
                                                      const Icon(

                                                    Icons.edit,

                                                    color:
                                                        Colors.blue,
                                                  ),
                                                ),

                                                IconButton(

                                                  onPressed:
                                                      () {

                                                    deleteUser(
                                                      user['employee_id'],
                                                    );
                                                  },

                                                  icon:
                                                      const Icon(

                                                    Icons.delete,

                                                    color:
                                                        Colors.red,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= MENU =================

  Widget buildMenu(
    IconData icon,
    String title,
  ) {

    return ListTile(

      leading: Icon(icon),

      title:
          isSidebarHover
              ? Text(title)
              : null,

      onTap: () {},
    );
  }

  // ================= TOP ICON =================

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