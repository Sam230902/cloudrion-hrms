import 'package:flutter/material.dart';
import 'edit_employee_drawer.dart';
import '../layouts/main_layout.dart';
import '../services/employee_service.dart';
import 'employee_view_screen.dart';
import 'admin_dashboard.dart';
import 'super_admin_dashboard.dart';
import 'hr_dashboard.dart';
import 'create_employee_screen.dart';
import 'create_employee_profile_screen.dart';

class EmployeeScreen extends StatefulWidget {

  final String userName;
  final String role;

  const EmployeeScreen({

    super.key,

    required this.userName,
    required this.role,
  });

  @override
  State<EmployeeScreen> createState() =>
      _EmployeeScreenState();
}

class _EmployeeScreenState
    extends State<EmployeeScreen> {
  final ScrollController _scrollController=ScrollController();
  // ================= LOADING =================
  bool isLoading = true;

  // ================= EMPLOYEE LIST =================
  List employees = [];

  // ================= COUNTS =================
  int totalEmployees = 0;
  int totalRoles = 0;
  int todayPresent = 0;
  int todayAbsent = 0;
  int totalDepartments = 0;

  // ================= SEARCH =================
  final TextEditingController
      searchController =
          TextEditingController();

  // ================= DROPDOWN =================
  String selectedDesignation =
      "All Designation";

  String selectedDepartment =
      "All Department";

  String selectedRole =
      "All Roles";

  // ================= INIT =================
  @override
  void initState() {

    super.initState();

    loadEmployees();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // ================= LOAD EMPLOYEE =================
  Future<void> loadEmployees() async {

    try {

      final data =
          await EmployeeService
              .getEmployees();

      final roles = data
          .map((e) => e["role"])
          .toSet()
          .toList();

      final departments = data
          .map((e) => e["department"])
          .toSet()
          .toList();

      setState(() {

        employees = data;

        totalEmployees =
            data.length;

        totalRoles =
            roles.length;

        totalDepartments =
            departments.length;

        todayPresent =
            data.where(
              (e) =>
                  e["status"] ==
                  "Active",
            ).length;

        todayAbsent =
            data.where(
              (e) =>
                  e["status"] !=
                  "Active",
            ).length;

        isLoading = false;
      });
    }

    catch (e) {

      setState(() {

        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            "Error : $e",
          ),
        ),
      );
    }
  }

  // ================= DELETE =================
  Future<void> deleteEmployee(String id) async {
    bool success =
      await EmployeeService.deleteEmployee(id);
    if (success) {
      loadEmployees();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
          elevation: 8,
          duration: const Duration(seconds: 3),
          
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.35,
            right: MediaQuery.of(context).size.width * 0.35,
            top: 20,
            bottom: MediaQuery.of(context).size.height - 120,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Employee Deleted Successfully",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  // ================= MENU =================
  void onMenuTap(String title) {

    if(title == "Dashboard") {

      if(widget.role ==
          "super_admin") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                SuperAdminDashboard(
              userName:
                  widget.userName,
              role: widget.role,
            ),
          ),
        );
      }

      else if(widget.role ==
          "admin") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                AdminDashboard(
              userName:
                  widget.userName,
              role: widget.role,
            ),
          ),
        );
      }

      else if(widget.role ==
          "hr") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_) =>
                HrDashboard(
              userName:
                  widget.userName,
              role: widget.role,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(

      role: widget.role,

      title:
          "Employee Management",

      userName:
          widget.userName,

      onLogout: () {},

      onMenuTap: onMenuTap,

      child:
          isLoading

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : Padding(

                  padding:
                      const EdgeInsets.all(
                    25,
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      // ================= FILTER =================
                      Row(

                        children: [

                          // ================= TOTAL =================
                          Container(

                            width: 150,
                            height: 65,

                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  Colors.white,

                              borderRadius:
                                  BorderRadius.circular(
                                14,
                              ),
                            ),

                            child: Column(

                              mainAxisAlignment:
                                  MainAxisAlignment.center,

                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                const Text(

                                  "Total Count",

                                  style: TextStyle(
                                    fontSize: 13,
                                    color:
                                        Colors.grey,
                                  ),
                                ),

                                const SizedBox(
                                  height: 4,
                                ),

                                Text(

                                  totalEmployees
                                      .toString(),

                                  style:
                                      const TextStyle(

                                    fontSize: 24,

                                    fontWeight:
                                        FontWeight.bold,

                                    color:
                                        Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          // ================= SEARCH =================
                          Expanded(

                            child: Container(

                              height: 60,

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    Colors.white,

                                borderRadius:
                                    BorderRadius.circular(
                                  14,
                                ),
                              ),

                              child: Row(

                                children: [

                                  const Icon(
                                    Icons.search,
                                    color:
                                        Colors.grey,
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Expanded(

                                    child: TextField(

                                      controller:
                                          searchController,

                                      decoration:
                                          const InputDecoration(

                                        hintText:
                                            "Search employee...",

                                        border:
                                            InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          dropdownBox(
                            selectedDesignation,
                            [
                              "All Designation",
                              "HR Manager",
                              "Developer",
                              "Tester",
                            ],
                            (v) {

                              setState(() {

                                selectedDesignation =
                                    v!;
                              });
                            },
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          dropdownBox(
                            selectedDepartment,
                            [
                              "All Department",
                              "HR",
                              "Development",
                              "Testing",
                            ],
                            (v) {

                              setState(() {

                                selectedDepartment =
                                    v!;
                              });
                            },
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          dropdownBox(
                            selectedRole,
                            [
                              "All Roles",
                              "Super Admin",
                              "Admin",
                              "HR",
                              "Employee",
                            ],
                            (v) {

                              setState(() {

                                selectedRole =
                                    v!;
                              });
                            },
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          // ================= CREATE =================
                          ElevatedButton.icon(

                            onPressed: () async {

                              final result =
                                  await Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      CreateEmployeeScreen(
                                    userName:
                                        widget.userName,
                                    role:
                                        widget.role,
                                  ),
                                ),
                              );
                              if (result == true) {
                                loadEmployees();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.white,
                                    elevation: 8,
                                    duration: const Duration(seconds: 3),
                                    margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.35,
                                      right: MediaQuery.of(context).size.width * 0.35,
                                      top: 20,
                                      bottom: MediaQuery.of(context).size.height - 120,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    content: const Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            "Employee Created Successfully",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                            },

                            style:
                                ElevatedButton.styleFrom(

                              backgroundColor:
                                  Colors.orange,

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 20,
                              ),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius.circular(
                                  12,
                                ),
                              ),
                            ),

                            icon: const Icon(
                              Icons.add,
                              color:
                                  Colors.white,
                            ),

                            label: const Text(

                              "Create Employee",

                              style: TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // ================= STATS =================
                      Row(

                        children: [

                          statsCard(
                            "Total Role",
                            totalRoles.toString(),
                            Colors.blue,
                          ),

                          const SizedBox(
                            width: 20,
                          ),

                          statsCard(
                            "Today Present",
                            todayPresent.toString(),
                            Colors.green,
                          ),

                          const SizedBox(
                            width: 20,
                          ),

                          statsCard(
                            "Today Absent",
                            todayAbsent.toString(),
                            Colors.red,
                          ),

                          const SizedBox(
                            width: 20,
                          ),

                          statsCard(
                            "Total Department",
                            totalDepartments
                                .toString(),
                            Colors.purple,
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // ================= TABLE =================
                      Expanded(
                        flex: 6,
                        child: Container(

                          padding:
                              const EdgeInsets.all(
                            20,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Column(

                            children: [

                              // ================= HEADER =================
                              Container(

                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 12,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color:
                                      Colors.orange
                                          .shade50,

                                  borderRadius:
                                      BorderRadius.circular(
                                    10,
                                  ),
                                ),

                                child: const Row(

                                  children: [

                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Employee ID",
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 5,
                                      child: Center(
                                        child: Text(
                                          "Employee",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          "Role",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),

                                    Expanded(
                                      flex: 4,
                                      child: Center(
                                        child: Text(
                                          "Department",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 5,
                                      child: Center(
                                        child: Text(
                                          "Email",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          "Status",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Text(
                                          "Action",
                                          style: TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              // ================= LIST =================
                              Expanded(

                                child:Scrollbar(
                                  controller: _scrollController,
                                  thumbVisibility: true,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount:employees.length,
                                    itemBuilder:(context, index) {
                                      final emp =employees[index];
                                      return Container(
                                        padding:const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 10,
                                        ),
                                        margin:const EdgeInsets.only(
                                          bottom: 12,
                                        ),
                                        decoration:BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius:BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Center(
                                                child: Text(
                                                  emp["employee_code"] ?? "",
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 220,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 18,
                                                        backgroundColor: Colors.orange.shade100,
                                                        backgroundImage:
                                                          emp["profile_image"] != null && emp["profile_image"].toString().isNotEmpty
                                                          ? NetworkImage(emp["profile_image"])
                                                          : null,
                                                          child:emp["profile_image"] == null || emp["profile_image"].toString().isEmpty? Text(
                                                            emp["first_name"][0].toUpperCase(),
                                                            style: const TextStyle(
                                                              color: Colors.orange,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ): null,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Flexible(
                                                        child: Text(
                                                          "${emp["first_name"]}${emp["middle_name"]} ${emp["last_name"]}",
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Text(
                                                  emp["role"] ??"",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 4,
                                              child: Center(
                                                child: Text(
                                                  emp["department"] ?? "",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Center(
                                                child: Text(
                                                  emp["email"] ?? "",
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Container(
                                                  width: 120,
                                                  height: 34,
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: 120,
                                                    height: 30,
                                                    alignment: Alignment.center,
                                                    decoration:
                                                        BoxDecoration(
                                                          color:emp["status"] =="Active"
                                                            ? Colors.green.shade50
                                                            : Colors.red.shade50,
                                                            borderRadius:BorderRadius.circular(
                                                              20,
                                                            ),
                                                        ),
                                                        child: Text(
                                                          emp["status"] ?? "",
                                                          textAlign:TextAlign.center,
                                                          style:TextStyle(
                                                            color:emp["status"] =="Active"
                                                              ? Colors.green
                                                              : Colors.red,
                                                              fontWeight:FontWeight.bold,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    //create profile
                                                    IconButton(
                                                      tooltip: "Create",
                                                      constraints: const BoxConstraints(),
                                                      padding: EdgeInsets.zero,
                                                      icon: const Icon(
                                                        Icons.badge,
                                                        color: Colors.deepPurple,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>CreateEmployeeProfileScreen(
                                                              employee: emp,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(width: 4),
                                                    // VIEW
                                                    IconButton(
                                                      tooltip: "View",
                                                      constraints: const BoxConstraints(),
                                                      padding: EdgeInsets.zero,
                                                      icon:const Icon(
                                                        Icons.visibility,color: Colors.green
                                                      ),
                                                
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>EmployeeViewScreen(
                                                              employee: emp,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(width: 4),
                                                    // EDIT
                                                    IconButton(
                                                      tooltip: "Edit",
                                                      constraints: const BoxConstraints(),
                                                      padding:EdgeInsets.zero,
                                                      icon:const Icon(
                                                        Icons.edit,color: Colors.blue
                                                      ),
                                                      onPressed: () async {
                                                        final result = await showGeneralDialog(
                                                          context: context,
                                                          barrierDismissible: true,
                                                          barrierLabel: "Edit",
                                                          transitionDuration:const Duration(milliseconds: 300),pageBuilder:(_, __, ___) {
                                                            return Align(
                                                              alignment:Alignment.centerRight,
                                                              child: EditEmployeeDrawer(
                                                                employee: emp,
                                                              ),
                                                            );
                                                          },
                                                          transitionBuilder:(_, animation, __, child) {
                                                            return SlideTransition(
                                                              position: Tween(
                                                                begin: const Offset(1, 0),
                                                                end: Offset.zero,
                                                              ).animate(animation),
                                                              child: child,
                                                            );
                                                          },
                                                        );
                                                        if (result == true) {
                                                          loadEmployees();
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(width: 4),
                                                    // DELETE
                                                    IconButton(
                                                      tooltip: "Delete",
                                                      constraints: const BoxConstraints(),
                                                      padding:EdgeInsets.zero,
                                                      icon:const Icon(
                                                        Icons.delete,color: Colors.red
                                                      ),
                                                      onPressed: () async {
                                                        bool? confirm = await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius:BorderRadius.circular(20),
                                                              ),
                                                              title: const Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.warning_amber_rounded,
                                                                    color: Colors.red,
                                                                  ),
                                                                  SizedBox(width: 10),
                                                                  Text(
                                                                    "Delete Employee",
                                                                  ),
                                                                ],
                                                              ),
                                                              content: Text(
                                                                "Are you sure you want to delete ${emp["first_name"]}?",
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                      context,
                                                                      false,
                                                                    );
                                                                  },
                                                                  child: const Text(
                                                                    "Cancel",
                                                                  ),
                                                                ),
                                                                ElevatedButton.icon(
                                                                  style:ElevatedButton.styleFrom(
                                                                    backgroundColor:Colors.red,
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                      context,
                                                                      true,
                                                                    );
                                                                  },
                                                                  icon: const Icon(
                                                                    Icons.delete,color: Colors.white,
                                                                  ),
                                                                  label: const Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (confirm == true) {
                                                          await deleteEmployee(
                                                            emp["id"],
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  // ================= DROPDOWN =================
  Widget dropdownBox(

    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {

    return Container(

      height: 60,

      padding:
          const EdgeInsets.symmetric(
        horizontal: 15,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: DropdownButtonHideUnderline(

        child: DropdownButton<String>(

          value: value,

          items:
              items.map((item) {

            return DropdownMenuItem(

              value: item,
              child: Text(item),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }

  // ================= STATS CARD =================
  Widget statsCard(

    String title,
    String value,
    Color color,
  ) {

    return Expanded(

      child: Container(

        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(

              title,

              style: TextStyle(

                color:
                    Colors.grey.shade600,

                fontSize: 15,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(

              value,

              style: TextStyle(

                fontSize: 28,

                color: color,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}