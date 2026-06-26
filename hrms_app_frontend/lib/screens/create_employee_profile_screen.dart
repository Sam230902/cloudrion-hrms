import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../services/employee_profile_service.dart';
import 'tabs/basic_tab.dart';
import 'tabs/personal_tab.dart';
import 'tabs/family_tab.dart';
import 'tabs/education_tab.dart';
import 'tabs/employment_tab.dart';
import 'tabs/projects_tab.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'employee_view_screen.dart';
class CreateEmployeeProfileScreen extends StatefulWidget {
  final Map employee;

  const CreateEmployeeProfileScreen({
    super.key,
    required this.employee,
  });

  @override
  State<CreateEmployeeProfileScreen> createState() =>
      _CreateEmployeeProfileScreenState();
}

class _CreateEmployeeProfileScreenState extends State<CreateEmployeeProfileScreen> {

  final _formKey = GlobalKey<FormState>();

  // BASIC
  final employeeIdController = TextEditingController();
  final employeeCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController =TextEditingController();
  final phoneController =TextEditingController();
  final passwordController =TextEditingController();
  final roleController =TextEditingController();
  final departmentController =TextEditingController();
  final designationController =TextEditingController();
  final joiningDateController =TextEditingController();


  // PERSONAL
  final dobController = TextEditingController();
  final ageController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final genderController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final religionController = TextEditingController();
  final nationalityController = TextEditingController();
  final nativeStateController = TextEditingController();
  final districtController = TextEditingController();
  final panNumberController = TextEditingController();
  final passportNumberController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final pincodeController = TextEditingController();

  // FAMILY
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final spouseNameController = TextEditingController();
  final childrenCountController = TextEditingController();
  final emergencyContactNameController =TextEditingController();
  final emergencyContactNumberController =TextEditingController();
  final relationshipController = TextEditingController();
  final occupationController = TextEditingController();

  // EDUCATION
  final tenthSchoolController = TextEditingController();
  final tenthBoardController = TextEditingController();
  final tenthPercentageController = TextEditingController();
  final tenthYearController = TextEditingController();

  final twelfthSchoolController = TextEditingController();
  final twelfthBoardController = TextEditingController();
  final twelfthPercentageController = TextEditingController();
  final twelfthYearController = TextEditingController();

  final diplomaCourseController = TextEditingController();
  final diplomaCollegeController = TextEditingController();
  final diplomaUniversityController = TextEditingController();
  final diplomaPercentageController = TextEditingController();
  final diplomaYearController = TextEditingController();

  final ugDegreeController = TextEditingController();
  final ugDepartmentController = TextEditingController();
  final ugCollegeController = TextEditingController();
  final ugUniversityController = TextEditingController();
  final ugPercentageController = TextEditingController();
  final ugYearController = TextEditingController();

  final pgDegreeController = TextEditingController();
  final pgSpecializationController = TextEditingController();
  final pgCollegeController = TextEditingController();
  final pgUniversityController = TextEditingController();
  final pgPercentageController = TextEditingController();
  final pgYearController = TextEditingController();

  // EMPLOYMENT
  final companyNameController = TextEditingController();
  final employmentdesignationController = TextEditingController();
  final employmentdepartmentController = TextEditingController();
  final employmentTypeController =TextEditingController();
  final workLocationController = TextEditingController();
  final employmentjoiningDateController = TextEditingController();
  final relievingDateController = TextEditingController();
  final noticePeriodController = TextEditingController();
  final previousCtcController = TextEditingController();
  final currentCtcController = TextEditingController();
  final expectedCtcController = TextEditingController();

  // PROJECT
  final projectNameController = TextEditingController();
  final clientNameController = TextEditingController();
  final projectDurationController =TextEditingController();
  final roleInProjectController =TextEditingController();
  final technologiesUsedController =TextEditingController();
  final projectDescriptionController =TextEditingController();

  bool isLoading = false;
  bool isPageLoading=true;

  double calculateProfileProgress() {
    int completedTabs = 0;
    // Basic
    if (employeeIdController.text.isNotEmpty &&
        employeeCodeController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty) {
          completedTabs++;
        }
    // Personal
    if (dobController.text.isNotEmpty &&
      bloodGroupController.text.isNotEmpty &&
      genderController.text.isNotEmpty) {
        completedTabs++;
      }

    // Family
    if (fatherNameController.text.isNotEmpty &&
      motherNameController.text.isNotEmpty) {
        completedTabs++;
      }

    // Education
    if (tenthSchoolController.text.isNotEmpty &&
      ugDegreeController.text.isNotEmpty) {
        completedTabs++;
      }

    // Employment
    if (companyNameController.text.isNotEmpty &&
      employmentTypeController.text.isNotEmpty) {
        completedTabs++;
      }

    // Projects
    if (projectNameController.text.isNotEmpty &&
      clientNameController.text.isNotEmpty) {
        completedTabs++;
      }

    return completedTabs / 6;
  }
  Future<void> loadProfile() async {
    final emp =await EmployeeProfileService.getProfile(
      widget.employee["employee_id"],
    );
    if (emp == null) return;
    setState(() {
      // PERSONAL
      dobController.text =
        emp["date_of_birth"] ?? "";

      ageController.text =
        (emp["age"] ?? "").toString();

      bloodGroupController.text =
        emp["blood_group"] ?? "";

      genderController.text =
        emp["gender"] ?? "";

      maritalStatusController.text =
        emp["marital_status"] ?? "";

      religionController.text =
        emp["religion"] ?? "";

      nationalityController.text =
        emp["nationality"] ?? "";

      nativeStateController.text =
        emp["native_state"] ?? "";

      districtController.text =
        emp["district"] ?? "";

      panNumberController.text =
        emp["pan_number"] ?? "";

      passportNumberController.text =
        emp["passport_number"] ?? "";

      heightController.text =
        (emp["height"] ?? "").toString();

      weightController.text =
        (emp["weight"] ?? "").toString();

      permanentAddressController.text =
        emp["permanent_address"] ?? "";

      pincodeController.text =
        emp["pincode"] ?? "";
    });
  }
  @override
  void initState() {
    super.initState();
    employeeIdController.text =
      widget.employee["id"] ?? "";

    employeeCodeController.text =
      widget.employee["employee_code"] ?? "";

    firstNameController.text =
      widget.employee["first_name"] ?? "";

    lastNameController.text =
      widget.employee["last_name"] ?? "";

    emailController.text =
      widget.employee["email"] ?? "";

    phoneController.text =
      widget.employee["phone"] ?? "";

    roleController.text =
      widget.employee["role"] ?? "";

    departmentController.text =
      widget.employee["department"] ?? "";

    designationController.text =
      widget.employee["designation"] ?? "";

    joiningDateController.text =
      widget.employee["joining_date"] ?? "";

    loadProfile();
    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        if (mounted) {
          setState(() {
            isPageLoading = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    employeeIdController.dispose();
    employeeCodeController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    roleController.dispose();
    departmentController.dispose();
    designationController.dispose();
    joiningDateController.dispose();

    dobController.dispose();
    ageController.dispose();
    bloodGroupController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
    religionController.dispose();
    nationalityController.dispose();
    nativeStateController.dispose();
    districtController.dispose();
    panNumberController.dispose();
    passportNumberController.dispose();
    heightController.dispose();
    weightController.dispose();
    permanentAddressController.dispose();
    pincodeController.dispose();

    fatherNameController.dispose();
    motherNameController.dispose();
    spouseNameController.dispose();
    childrenCountController.dispose();
    emergencyContactNameController.dispose();
    emergencyContactNumberController.dispose();
    relationshipController.dispose();
    occupationController.dispose();

    tenthSchoolController.dispose();
    tenthBoardController.dispose();
    tenthPercentageController.dispose();
    tenthYearController.dispose();

    twelfthSchoolController.dispose();
    twelfthBoardController.dispose();
    twelfthPercentageController.dispose();
    twelfthYearController.dispose();

    diplomaCourseController.dispose();
    diplomaCollegeController.dispose();
    diplomaUniversityController.dispose();
    diplomaPercentageController.dispose();
    diplomaYearController.dispose();

    ugDegreeController.dispose();
    ugDepartmentController.dispose();
    ugCollegeController.dispose();
    ugUniversityController.dispose();
    ugPercentageController.dispose();
    ugYearController.dispose();

    pgDegreeController.dispose();
    pgSpecializationController.dispose();
    pgCollegeController.dispose();
    pgUniversityController.dispose();
    pgPercentageController.dispose();
    pgYearController.dispose();

    companyNameController.dispose();
    designationController.dispose();
    departmentController.dispose();
    employmentTypeController.dispose();
    workLocationController.dispose();
    joiningDateController.dispose();
    relievingDateController.dispose();
    noticePeriodController.dispose();
    previousCtcController.dispose();
    currentCtcController.dispose();
    expectedCtcController.dispose();

    projectNameController.dispose();
    clientNameController.dispose();
    projectDurationController.dispose();
    roleInProjectController.dispose();
    technologiesUsedController.dispose();
    projectDescriptionController.dispose();
    
    super.dispose();
  }

  Future<void> saveProfile() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    EasyLoading.show(
      status: "Saving...",
    );

    final data = {

      // BASIC
      "employee_id": employeeIdController.text,
      "employee_code": employeeCodeController.text,
      "first_name": firstNameController.text,
      "middle_name": middleNameController.text,
      "last_name": lastNameController.text,
      "email":emailController.text,
      "phone":phoneController.text,
      "password": passwordController.text,
      "role":roleController.text,
      "department":departmentController.text,
      "designation":designationController.text,
      "joining_date":joiningDateController.text,

      // PERSONAL
      "date_of_birth": dobController.text,
      "age": int.tryParse(ageController.text) ?? 0,
      "blood_group": bloodGroupController.text,
      "gender": genderController.text,
      "marital_status": maritalStatusController.text,
      "religion": religionController.text,
      "nationality": nationalityController.text,
      "native_state": nativeStateController.text,
      "district": districtController.text,
      "pan_number": panNumberController.text,
      "passport_number": passportNumberController.text,
      "height":double.tryParse(heightController.text) ?? 0,
      "weight":double.tryParse(weightController.text) ?? 0,
      "permanent_address":permanentAddressController.text,
      "pincode":pincodeController.text,

      // FAMILY
      "father_name": fatherNameController.text,
      "mother_name": motherNameController.text,
      "spouse_name": spouseNameController.text,
      "children_count":
          int.tryParse(childrenCountController.text) ?? 0,
      "emergency_contact_name":
          emergencyContactNameController.text,
      "emergency_contact_number":
          emergencyContactNumberController.text,
      "relationship":
          relationshipController.text,
      "occupation":
          occupationController.text,

      // EDUCATION
      "tenth_school_name":
          tenthSchoolController.text,
      "tenth_board":
          tenthBoardController.text,
      "tenth_percentage":
          double.tryParse(
            tenthPercentageController.text,
          ) ??
          0,
      "tenth_passed_out_year":
          int.tryParse(
            tenthYearController.text,
          ) ??
          0,

      "twelfth_school_name":
          twelfthSchoolController.text,
      "twelfth_board":
          twelfthBoardController.text,
      "twelfth_percentage":
          double.tryParse(
            twelfthPercentageController.text,
          ) ??
          0,
      "twelfth_passed_out_year":
          int.tryParse(
            twelfthYearController.text,
          ) ??
          0,
      "diploma_course_name":
        diplomaCourseController.text,
      "diploma_college_name":
        diplomaCollegeController.text,
      "diploma_university":
        diplomaUniversityController.text,
      "diploma_percentage":
        double.tryParse(
          diplomaPercentageController.text,
        ) ?? 0,
      "diploma_passed_out_year":
        int.tryParse(
          diplomaYearController.text,
        ) ?? 0,


      "ug_degree_name":
          ugDegreeController.text,
      "ug_department":
          ugDepartmentController.text,
      "ug_college_name":
          ugCollegeController.text,
      "ug_university_name":
          ugUniversityController.text,
      "ug_percentage":
          double.tryParse(
            ugPercentageController.text,
          ) ??
          0,
      "ug_passed_out_year":
          int.tryParse(
            ugYearController.text,
          ) ??
          0,
      "pg_degree_name":
        pgDegreeController.text,
      "pg_specialization":
        pgSpecializationController.text,
      "pg_college_name":
        pgCollegeController.text,
      "pg_university_name":
        pgUniversityController.text,
      "pg_percentage":
        double.tryParse(
          pgPercentageController.text,
        ) ?? 0,
      "pg_passed_out_year":
        int.tryParse(
          pgYearController.text,
        ) ?? 0,

      // EMPLOYMENT
      "company_name":
          companyNameController.text,
      "employment_designation":
          employmentdesignationController.text,
      "employment_department":
          employmentdepartmentController.text,
      "employment_type":
          employmentTypeController.text,
      "work_location":
          workLocationController.text,
      "joining":
          employmentjoiningDateController.text,
      "relieving_date":
        relievingDateController.text,
      "notice_period":
        noticePeriodController.text,
      "previous_ctc":
        previousCtcController.text,
      "current_company": true,
      "current_ctc":
        currentCtcController.text,
      "expected_ctc":
        expectedCtcController.text,

      // PROJECT
      "project_name":
          projectNameController.text,
      "client_name":
          clientNameController.text,
      "project_duration":
          projectDurationController.text,
      "role_in_project":
          roleInProjectController.text,
      "technologies_used":
          technologiesUsedController.text,
      "project_description":
          projectDescriptionController.text,
    };

    bool success =
        await EmployeeProfileService.createProfile(
      data,
    );
    EasyLoading.dismiss();
    if (success) {
      EasyLoading.showSuccess("Profile Created");
      await Future.delayed(
        const Duration(seconds: 1),
      );
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => EmployeeViewScreen(
            employee: widget.employee,
            showSuccess: true,
          ),
        ),
      );
    } else {
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
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Profile Creation Failed",
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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            "Create Employee Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Basic"),
              Tab(text: "Personal"),
              Tab(text: "Family"),
              Tab(text: "Education"),
              Tab(text: "Employment"),
              Tab(text: "Projects"),
            ],
          ),
        ),
        body: Skeletonizer(
          enabled: isPageLoading,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      BasicTab(
                        employee: widget.employee,
                        employeeIdController: employeeIdController, 
                        employeeCodeController: employeeCodeController, 
                        firstNameController: firstNameController, 
                        middleNameController: middleNameController, 
                        lastNameController: lastNameController,
                        emailController:emailController,
                        phoneController:phoneController,
                        roleController:roleController,
                        departmentController:departmentController,
                        designationController:designationController,
                        joiningDateController:joiningDateController,
                        percentage: (calculateProfileProgress() * 100).round(),
                          
                      ),
                      PersonalTab(
                        dobController: dobController, 
                        ageController: ageController, 
                        bloodGroupController: bloodGroupController, 
                        genderController: genderController, 
                        maritalStatusController: maritalStatusController, 
                        religionController: religionController, 
                        nationalityController: nationalityController, 
                        nativeStateController: nativeStateController,
                        districtController:districtController,
                        panNumberController:panNumberController,
                        passportNumberController:passportNumberController,
                        heightController:heightController,
                        weightController:weightController,
                        permanentAddressController:permanentAddressController,
                        pincodeController:pincodeController
                      ),
                      FamilyTab(
                        fatherNameController: fatherNameController, 
                        motherNameController: motherNameController, 
                        spouseNameController: spouseNameController, 
                        childrenCountController: childrenCountController, 
                        emergencyContactNameController: emergencyContactNameController, 
                        emergencyContactNumberController: emergencyContactNumberController, 
                        relationshipController: relationshipController, occupationController: 
                        occupationController
                      ),
                      EducationTab(
                        tenthSchoolController: tenthSchoolController, 
                        tenthBoardController: tenthBoardController, 
                        tenthPercentageController: tenthPercentageController, 
                        tenthYearController: tenthYearController, 
                        
                        twelfthSchoolController: twelfthSchoolController, 
                        twelfthBoardController: twelfthBoardController, 
                        twelfthPercentageController: twelfthPercentageController, 
                        twelfthYearController: twelfthYearController, 

                        diplomaCourseController: diplomaCourseController, 
                        diplomaCollegeController: diplomaCollegeController, 
                        diplomaUniversityController: diplomaUniversityController, 
                        diplomaPercentageController: diplomaPercentageController, 
                        diplomaYearController: diplomaYearController, 
                        
                        ugDegreeController: ugDegreeController, 
                        ugDepartmentController: ugDepartmentController, 
                        ugCollegeController: ugCollegeController, 
                        ugUniversityController: ugUniversityController, 
                        ugPercentageController: ugPercentageController, 
                        ugYearController: ugYearController, 
                        
                        pgDegreeController: pgDegreeController, 
                        pgSpecializationController: pgSpecializationController, 
                        pgCollegeController: pgCollegeController, 
                        pgUniversityController: pgUniversityController, 
                        pgPercentageController: pgPercentageController, 
                        pgYearController: pgYearController
                      ),
                      EmploymentTab(
                        companyNameController: companyNameController, 
                        designationController: employmentdesignationController, 
                        departmentController: employmentdepartmentController, 
                        employmentTypeController: employmentTypeController, 
                        workLocationController: workLocationController, 
                        joiningDateController: employmentjoiningDateController, 
                        relievingDateController: relievingDateController, 
                        noticePeriodController: noticePeriodController, 
                        previousCtcController: previousCtcController, 
                        currentCtcController: currentCtcController, 
                        expectedCtcController: expectedCtcController
                      ),
                      ProjectsTab(
                        onFinish: saveProfile,
                        projectNameController: projectNameController, 
                        clientNameController: clientNameController, 
                        projectDurationController: projectDurationController, 
                        roleInProjectController: roleInProjectController, 
                        technologiesUsedController: technologiesUsedController, 
                        projectDescriptionController: projectDescriptionController
                      ),
                    ],
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