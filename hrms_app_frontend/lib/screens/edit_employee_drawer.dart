import 'package:flutter/material.dart';
import '../services/employee_service.dart';

class EditEmployeeDrawer extends StatefulWidget {
  final Map employee;
  const EditEmployeeDrawer({
    super.key,
    required this.employee,
  });
  @override
  State<EditEmployeeDrawer> createState() =>_EditEmployeeDrawerState();
}
class _EditEmployeeDrawerState extends State<EditEmployeeDrawer> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool loading = false;
  String role = "Employee";
  bool isActive = true;
  
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text:"${widget.employee["first_name"] ?? ""} ${widget.employee["last_name"] ?? ""}",
    );
    emailController = TextEditingController(
      text: widget.employee["email"] ?? "",
    );
    phoneController = TextEditingController(
      text: widget.employee["phone"] ?? "",
    );
    role =widget.employee["role"] ??"Employee";
    
    isActive =widget.employee["status"] =="Active";
  }
  Future<void> updateEmployee() async {
    setState(() {
      loading = true;
    });
    List<String> names =nameController.text.trim().split(" ");
    String firstName =names.isNotEmpty
        ? names.first
        : "";
    String lastName =names.length > 1
        ? names.sublist(1).join(" ")
        : "";
    Map<String, dynamic> data = {
      "employee_id":widget.employee["employee_id"],
      "employee_code":widget.employee["employee_code"],
      "first_name":firstName,
      "last_name":lastName,
      "email":emailController.text,
      "phone":phoneController.text,
      "role":role,
      "department":widget.employee["department"],
      "designation":widget.employee["designation"],
      "joining_date":widget.employee["joining_date"],
      "status":isActive
          ? "Active"
          : "Inactive",
    };

    final result = await EmployeeService.updateEmployee(
      widget.employee["id"].toString(),
      data,
    );
    bool success = result["success"];
    
    setState(() {
      loading = false;
    });

    if (success) {
      Navigator.pop(
        context,
        true,
      );
      
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
                  "Employee Updated Successfully",
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
                  "Failed To Update Employee",
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
    return Material(
      color: Colors.white,
      child: Container(
        width: 420,
        height: double.infinity,
        padding:const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Employee",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Employee Name",
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller:nameController,
              decoration:
                const InputDecoration(
                  border:
                    OutlineInputBorder(),
                ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Email",
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller:emailController,
              decoration:
                const InputDecoration(
                  border:
                    OutlineInputBorder(),
                ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Phone",
            ),
            const SizedBox(
               height: 8,
            ),
            TextField(
              controller:phoneController,
              decoration:
                const InputDecoration(
                  border:
                    OutlineInputBorder(),
                ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Role",
            ),
            const SizedBox(
              height: 8,
            ),
            DropdownButtonFormField<String>(
              value: role,
              items: const [
                DropdownMenuItem(
                  value: "Super Admin",
                  child: Text(
                    "Super Admin",
                  ),
                ),
                DropdownMenuItem(
                  value: "Admin",
                  child: Text(
                    "Admin",
                  ),
                ),
                DropdownMenuItem(
                  value: "HR Manager",
                  child: Text(
                    "HR Manager",
                  ),
                ),
                DropdownMenuItem(
                  value: "Employee",
                  child: Text(
                    "Employee",
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  role =value ?? "";
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Status",
            ),
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue:isActive,
                  onChanged: (v) {
                    setState(() {
                      isActive = true;
                    });
                  },
                ),
                const Text(
                  "Active",
                ),
                Radio<bool>(
                  value: false,
                  groupValue:isActive,
                  onChanged: (v) {
                    setState(() {
                      isActive = false;
                    });
                  },
                ),
                const Text(
                  "Inactive",
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:loading
                    ? null
                    : updateEmployee,
                    style:ElevatedButton.styleFrom(
                      backgroundColor:Colors.orange,
                    ),
                    child:
                      loading
                      ? const CircularProgressIndicator(
                        color:
                            Colors.white,
                      )
                      : const Text(
                        "Save Changes",
                        style:
                          TextStyle(
                            color:Colors.white,
                            fontWeight:FontWeight.bold,
                          ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
