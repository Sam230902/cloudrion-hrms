import 'package:flutter/material.dart';
import '../services/employee_profile_service.dart';

class EmployeeViewScreen extends StatefulWidget {
  final Map employee;
  final bool showSuccess;
  

  const EmployeeViewScreen({
    super.key,
    required this.employee,
    this.showSuccess = false,
  });

  @override
  State<EmployeeViewScreen> createState() =>
      _EmployeeViewScreenState();
}

class _EmployeeViewScreenState extends State<EmployeeViewScreen>with SingleTickerProviderStateMixin {

  late TabController _tabController;
  Map<String, dynamic>? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 6,
      vsync: this,
    );
    _loadProfile();
    if (widget.showSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
              bottom:
                MediaQuery.of(context).size.height - 120,
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
                    "Profile Created Successfully",
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
      });
    }
  }
  Future<void> _loadProfile() async {
    try {
      profile = await EmployeeProfileService.getProfile(
        widget.employee["employee_code"],
      );
      print("PROFILE DATA = $profile");
    } catch (e) {
      print("PROFILE ERROR = $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final e = widget.employee;
    final p = profile ?? {};

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          "${e["first_name"]} ${e["last_name"]}",
        ),
      ),

      body: Row(
        children: [

          /// LEFT SIDE PROFILE CARD

          Container(
            width: 320,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.deepPurple.shade100,
                    backgroundImage:
                    (e["profile_image"] != null && 
                      e["profile_image"]
                        .toString()
                        .startsWith("http"))
                      ? NetworkImage(
                          e["profile_image"],
                        )
                      : null,
                      child: e["profile_image"] == null ||e["profile_image"].toString().isEmpty ? const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )
                      : null,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${e["first_name"]} ${e["middle_name"]} ${e["last_name"]}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    e["designation"] ?? "",
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                  ),
                  const Divider(height: 40),
                  profileTile(
                    Icons.badge,
                    "Employee ID",
                    e["employee_code"],
                  ),
                  profileTile(
                    Icons.business,
                    "Department",
                    e["department"],
                  ),
                  profileTile(
                    Icons.person,
                    "Role",
                    e["role"],
                  ),
                  profileTile(
                    Icons.phone,
                    "Phone",
                    e["phone"],
                  ),
                  profileTile(
                    Icons.email,
                    "Email",
                    e["email"],
                  ),
                ],
              ),
            ),
          ),

          /// RIGHT SIDE TABS

          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.orange,
                    unselectedLabelColor: Colors.black,

                    tabs: const [
                      Tab(text: "Basic"),
                      Tab(text: "Personal"),
                      Tab(text: "Family"),
                      Tab(text: "Education"),
                      Tab(text: "Employment"),
                      Tab(text: "Projects"),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [

                        /// BASIC
                        detailsSection([
                          item("Employee ID",e["employee_id"]),
                          item("Employee Code",e["employee_code"]),
                          item("First Name",e["first_name"]),
                          item("Middle Name",e["middle_name"]),
                          item("Last Name",e["last_name"]),
                          item("Department",e["department"]),
                          item("Designation",e["designation"]),
                          item("Joining Date",e["joining_date"]),
                        ]),

                        /// PERSONAL

                        detailsSection([
                          item("DOB",p["date_of_birth"]),
                          item("Age",p["age"]),
                          item("Blood Group",p["blood_group"]),
                          item("Gender",p["gender"]),
                          item("Marital Status", p["marital_status"]),
                          item("Religion",p["religion"]),
                          item("Nationality",p["nationality"]),
                          item("Native State", p["native_state"]),
                          item("District", p["district"]),
                          item("PAN",p["pan_number"]),
                          item("Passport",p["passport_number"]),
                          item("Height",p["height"]),
                          item("Weight",p["weight"]),
                          item("Permanent Address", p["permanent_address"]),
                          item("Pincode", p["pincode"]),
                        ]),

                        /// FAMILY

                        detailsSection([
                          item("Father",p["father_name"]),
                          item("Mother",p["mother_name"]),
                          item("Spouse",p["spouse_name"]),
                          item("Children",p["children_count"]),
                          item("Emergency Contact",p["emergency_contact_name"]),
                          item("Emergency Phone",p["emergency_contact_number"]),
                          item("Relationship",p["relationship"]),
                          item("Occupation", p["occupation"]),
                        ]),

                        /// EDUCATION
                        
                        detailsSection([
                          item("10th School", p["tenth_school_name"]),
                          item("10th Board", p["tenth_board"]),
                          item("10th Percentage", p["tenth_percentage"]),
                          item("10th Passed Year", p["tenth_passed_out_year"]),
                          item("12th School", p["twelfth_school_name"]),
                          item("12th Board", p["twelfth_board"]),
                          item("12th Percentage", p["twelfth_percentage"]),
                          item("12th Passed Year", p["twelfth_passed_out_year"]),
                          item("Diploma Course", p["diploma_course_name"]),
                          item("Diploma College", p["diploma_college_name"]),
                          item("Diploma University", p["diploma_university"]),
                          item("Diploma Percentage", p["diploma_percentage"]),
                          item("Diploma Passed Year", p["diploma_passed_out_year"]),
                          item("UG Degree", p["ug_degree_name"]),
                          item("UG Department", p["ug_department"]),
                          item("UG College", p["ug_college_name"]),
                          item("UG University", p["ug_university_name"]),
                          item("UG Percentage", p["ug_percentage"]),
                          item("UG Passed Year", p["ug_passed_out_year"]),
                          item("PG Degree", p["pg_degree_name"]),
                          item("PG Specialization", p["pg_specialization"]),
                          item("PG College", p["pg_college_name"]),
                          item("PG University", p["pg_university_name"]),
                          item("PG Percentage", p["pg_percentage"]),
                          item("PG Passed Year", p["pg_passed_out_year"]),
                        ]),

                        /// EMPLOYMENT
                        
                        detailsSection([
                          item("Company Name", p["company_name"]),
                          item("Designation", p["employment_designation"]),
                          item("Department", p["employment_department"]),
                          item("Employment Type", p["employment_type"]),
                          item("Work Location", p["work_location"]),
                          item("Joining Date", p["joining"]),
                          item("Relieving Date", p["relieving_date"]),
                          item("Notice Period", p["notice_period"]),
                          item("Previous CTC", p["previous_ctc"]),
                          item("Current CTC", p["current_ctc"]),
                          item("Expected CTC", p["expected_ctc"]),
                        ]),

                        /// PROJECTS

                        detailsSection([
                          item("Project Name",p["project_name"]),
                          item("Client",p["client_name"]),
                          item("Duration",p["project_duration"]),
                          item("Role",p["role_in_project"]),
                          item("Technology",p["technologies_used"]),
                          item("Description",p["project_description"]),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileTile(
      IconData icon,
      String title,
      dynamic value) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(title),
      subtitle: Text(
        value?.toString() ?? "-",
      ),
    );
  }

  Widget detailsSection(
    List<Map<String, dynamic>> items,
    ) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment:
                  CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 220,
                    child: Text(
                      item["title"],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Text(
                    ":",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: Text(
                      item["value"]
                            ?.toString() ??
                        "-",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> item(
    String title,
    dynamic value,
  ) {
    return {
      "title": title,
      "value": value,
    };
  }
}