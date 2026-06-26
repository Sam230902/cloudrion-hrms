// ================= create_employee_screen.dart =================
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../layouts/main_layout.dart';
import '../services/employee_service.dart';


class CreateEmployeeScreen extends StatefulWidget {
  final String userName;
  final String role;
  final bool isEdit;
  final Map<String, dynamic>? employeeData;
  const CreateEmployeeScreen({
    super.key,
    required this.userName,
    required this.role,
    this.isEdit = false,
    this.employeeData,
  });

  @override
  State<CreateEmployeeScreen> createState() =>
      _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState
    extends State<CreateEmployeeScreen> {

  bool loading = false;
  bool showValidation = false;
  Uint8List?webImage;
  File? profileImage;
  String? errorMessage;
  String?profilePhotoUrl;

  // ================= CONTROLLERS =================

  final employeeIdController =TextEditingController();
  final employeeCodeController =TextEditingController();
  final firstNameController =TextEditingController();
  final middleNameController=TextEditingController();
  final lastNameController =TextEditingController();
  final emailController =TextEditingController();
  final phoneController =TextEditingController();
  final passwordController =TextEditingController();
  final roleController =TextEditingController();
  final departmentController =TextEditingController();
  final designationController =TextEditingController();
  final joiningDateController =TextEditingController();

  
  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.employeeData != null) {
      employeeIdController.text =
        widget.employeeData!["employee_id"] ?? "";

      employeeCodeController.text =
        widget.employeeData!["employee_code"] ?? "";

      firstNameController.text =
        widget.employeeData!["first_name"] ?? "";

      middleNameController.text =
        widget.employeeData!["middle_name"] ?? "";

      lastNameController.text =
        widget.employeeData!["last_name"] ?? "";

      emailController.text =
        widget.employeeData!["email"] ?? "";

      phoneController.text =
        widget.employeeData!["phone"] ?? "";

      roleController.text =
        widget.employeeData!["role"] ?? "";

      departmentController.text =
        widget.employeeData!["department"] ?? "";

      designationController.text =
        widget.employeeData!["designation"] ?? "";

      profilePhotoUrl =
        widget.employeeData!["profile_photo"];

      if (widget.employeeData!["joining_date"] != null) {
        try {
          final date = DateTime.parse(
            widget.employeeData!["joining_date"],
          );
          joiningDateController.text =
            DateFormat("dd-MM-yyyy")
                .format(date);
        } catch (e) {
          joiningDateController.text =
            widget.employeeData!["joining_date"] ?? "";
        }
      }
    }
  }

  // ================= DROPDOWN =================

  final List<String> roles = [

    "Super Admin",
    "Admin",
    "HR",
    "Employee",
  ];

  final List<String> departments = [

    "Development",
    "Testing",
    "HR",
    "Management",
  ];

  final List<String> designations = [

    "Software Developer",
    "UI UX Designer",
    "Tester",
    "HR",
    "Manager",
  ];

  // ================= DATE PICKER =================

  Future<void> pickJoiningDate() async {

    final DateTime? picked =await showDatePicker(

      context: context,

      initialDate: DateTime.now(),

      firstDate: DateTime(1950),

      lastDate: DateTime(2100),
    );

    if(picked != null) {

      joiningDateController.text =
          DateFormat(
            "dd-MM-yyyy",
          ).format(picked);

      setState(() {});
    }
  }

  Future<void> pickProfileImage() async {
    FilePickerResult? result =
      await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );
      if (result != null) {
        if (kIsWeb){
          setState(() {
            webImage= result.files.first.bytes;
          });
        }else{
          setState(() {
            profileImage=File(
              result.files.single.path!,
            );
          });
        }
        
      }
    }

  // ================= VALIDATION =================

  bool validateForm() {

    List<TextEditingController> fields = [

      employeeIdController,
      employeeCodeController,
      firstNameController,
      middleNameController,
      lastNameController,
      emailController,
      phoneController,
      passwordController,
      roleController,
      departmentController,
      designationController,
      joiningDateController,
    ];

    for(var field in fields) {

      if(field.text.trim().isEmpty) {

        return false;
      }
    }

    return true;
  }

  // ================= SUBMIT =================

  Future<void> submitForm() async {

    setState(() {
      loading = true;
      errorMessage = null;
    });

    Map<String,dynamic> data = {

      "employee_id":
          employeeIdController.text,

      "employee_code":
          employeeCodeController.text,

      "first_name":
          firstNameController.text,

      "middle_name":
          middleNameController.text,

      "last_name":
          lastNameController.text,

      "email":
          emailController.text,

      "phone":
          phoneController.text,

      "password":
          passwordController.text,

      "role":
          roleController.text,

      "manager_id":
          "",

      "department":
          departmentController.text,

      "designation":
          designationController.text,

      "joining_date":
          joiningDateController.text,

      "status":
          "Active",
    };
    final result = widget.isEdit ? await EmployeeService.updateEmployee(
      widget.employeeData!["id"],
      data,
    )
    : await EmployeeService.addEmployee(
      data.map(
        (key, value) =>
              MapEntry(key, value.toString()),
      ),
      profileImage,
      webImage,
    );
    bool success = result["success"] ?? false;
    
    setState(() {
      loading = false;
    });

    if (success) {
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
          content: Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.isEdit
                  ? "Employee Updated Successfully"
                  : "Employee Created Successfully",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () {
          if (mounted) {
            Navigator.pop(context, true);
          }
        },
      );
    } else {
      setState(() {
        errorMessage = result["message"];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            result["message"] ?? "Failed To Create Employee",
          ),
        ),
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(

      role: widget.role,

      title: widget.isEdit
            ? "Edit Employee"
            :"Create Employee",

      userName: widget.userName,

      onLogout: () {},

      onMenuTap: (value) {},

      child: SingleChildScrollView(

        padding: const EdgeInsets.all(25),

        child: Container(

          width: double.infinity,

          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(20),
          ),

          child: Column(

            children: [
              if (errorMessage != null)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: pickProfileImage,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.orange,
                            width: 3,
                          ),
                          image: webImage != null? DecorationImage(
                            image: MemoryImage(webImage!),
                            fit: BoxFit.cover,
                          )
                          : profileImage != null? DecorationImage(
                            image: FileImage(profileImage!),
                            fit: BoxFit.cover,
                          )
                          : profilePhotoUrl != null &&profilePhotoUrl!.isNotEmpty? DecorationImage(
                            image: NetworkImage(
                              profilePhotoUrl!,
                            ),
                            fit: BoxFit.cover,
                          )
                          : null,
                        ),
                        child: webImage == null && profileImage == null? const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.orange,
                        ):null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: pickProfileImage,
                      icon: const Icon(
                        Icons.upload,
                      ),
                      label: const Text(
                        "Upload Profile Image",
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),

              build3Fields(

                buildField(
                  "Employee ID",
                  employeeIdController,
                  required: true,
                ),

                buildField(
                  "Employee Code",
                  employeeCodeController,
                  required: true,
                ),

                buildField(
                  "First Name",
                  firstNameController,
                  required: true,
                ),
              ),

              build3Fields(

                buildField(
                  "Middle Name",
                  middleNameController,
                  required: true,
                ),

                buildField(
                  "Last Name",
                  lastNameController,
                  required: true,
                ),

                buildField(
                  "Email",
                  emailController,
                  required: true,
                ),
              ),

              build3Fields(

                buildField(
                  "Phone Number",
                  phoneController,
                  required: true,
                ),

                buildField(
                  "Password",
                  passwordController,
                  required: true,
                  obscure: true,
                ),

                buildDropdownField(
                  "Role",
                  roleController,
                  roles,
                  required: true,
                ),
              ),

              build3Fields(

                buildDropdownField(
                  "Department",
                  departmentController,
                  departments,
                  required: true,
                ),

                buildDropdownField(
                  "Designation",
                  designationController,
                  designations,
                  required: true,
                ),

                buildCalendarField(),
              ),

              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 180,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: loading? null: () async {
                        setState(() {
                          showValidation = true;
                        });
                        if (!validateForm()) return;
                        await submitForm();
                      },
                      icon: loading? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Icon(
                        Icons.person_add_alt_1,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        "Create Employee",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  // ================= FIELD =================

  Widget buildField(

    String hint,

    TextEditingController controller, {

    bool required = false,

    bool obscure = false,
  }) {

    bool hasError =

        showValidation &&
        required &&
        controller.text.trim().isEmpty;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: TextField(

        controller: controller,

        obscureText: obscure,

        decoration: InputDecoration(

          hintText: hint,

          errorText:
              hasError
                  ? "Required"
                  : null,

          filled: true,

          fillColor:
              const Color(0xFFF5F7FB),

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget buildDropdownField(

    String hint,

    TextEditingController controller,

    List<String> items, {

    bool required = false,
  }) {

    bool hasError =

        showValidation &&
        required &&
        controller.text.isEmpty;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child:
          DropdownButtonFormField<String>(

        value:
            controller.text.isEmpty
                ? null
                : controller.text,

        items:
            items.map((item) {

          return DropdownMenuItem(

            value: item,

            child: Text(item),
          );
        }).toList(),

        onChanged: (value) {

          controller.text =
              value ?? "";

          setState(() {});
        },

        decoration: InputDecoration(

          hintText: hint,

          errorText:
              hasError
                  ? "Required"
                  : null,

          filled: true,

          fillColor:
              const Color(0xFFF5F7FB),

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================= DATE =================

  Widget buildCalendarField() {

    bool hasError =

        showValidation &&
        joiningDateController.text.isEmpty;

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 18,
      ),

      child: TextField(

        controller:
            joiningDateController,

        readOnly: true,

        onTap: pickJoiningDate,

        decoration: InputDecoration(

          hintText:
              "Joining Date",

          errorText:
              hasError
                  ? "Required"
                  : null,

          suffixIcon:
              const Icon(
            Icons.calendar_month,
          ),

          filled: true,

          fillColor:
              const Color(0xFFF5F7FB),

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // ================= ROW =================

  Widget build3Fields(
    Widget one,
    Widget two,
    Widget three,
  ) {

    return Row(

      children: [

        Expanded(child: one),

        const SizedBox(width: 15),

        Expanded(child: two),

        const SizedBox(width: 15),

        Expanded(child: three),
      ],
    );
  }
}