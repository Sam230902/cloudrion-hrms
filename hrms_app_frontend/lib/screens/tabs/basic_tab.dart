import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class BasicTab extends StatefulWidget {
  final TextEditingController employeeIdController;
  final TextEditingController employeeCodeController;
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController roleController;
  final TextEditingController departmentController;
  final TextEditingController designationController;
  final TextEditingController joiningDateController;
  final Map employee;
  final int percentage;
  
  const BasicTab({
    super.key,
    required this.employee,
    required this.employeeIdController,
    required this.employeeCodeController,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.roleController,
    required this.departmentController,
    required this.designationController,
    required this.joiningDateController,
    required this.percentage,
  });

  @override
  State<BasicTab> createState() => _BasicTabState();
  }
  class _BasicTabState extends State<BasicTab> {
    Uint8List? profileImageBytes;
    Future<void> pickImage() async {
      final picker = ImagePicker();
      final XFile? image =await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          profileImageBytes = bytes;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    double progress = widget.percentage / 100;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT PANEL
          Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "Profile Completion",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  width: 160,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 160,
                        width: 160,
                        child: CircularProgressIndicator(
                          value:progress,
                          strokeWidth: 12,
                          color: Colors.green,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "${widget.percentage}%",
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "${widget.percentage}% Completed",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _stepTile("1", "Basic", true),
                _stepTile("2", "Personal", false),
                _stepTile("3", "Family", false),
                _stepTile("4", "Education", false),
                _stepTile("5", "Employment", false),
                _stepTile("6", "Projects", false),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // RIGHT PANEL
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Basic Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // PROFILE PHOTO CENTER
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.orange,
                                width: 2,
                              ),
                              image: profileImageBytes != null? DecorationImage(
                                image: MemoryImage(profileImageBytes!),
                                fit: BoxFit.cover,
                              )
                              : widget.employee["profile_image"] != null &&widget.employee["profile_image"].toString().isNotEmpty? DecorationImage(
                                image: NetworkImage(
                                  widget.employee["profile_image"],
                                ),
                                fit: BoxFit.cover,
                              )
                              : null,
                              
                            ),
                            child: profileImageBytes == null &&(widget.employee["profile_image"] == null ||
                              widget.employee["profile_image"].toString().isEmpty)? const Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.orange,
                              )
                              : null,
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: pickImage,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Upload Photo"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      build3Fields(
                        _field(
                          widget.employeeIdController,
                          "Employee ID",
                        ),
                        _field(
                          widget.employeeCodeController,
                          "Employee Code",
                        ),
                        _field(
                          widget.firstNameController,
                          "First Name",
                        ),
                      ),
                      const SizedBox(height: 15),
                      build3Fields(
                        _field(
                          widget.middleNameController,
                          "Middle Name",
                        ),
                        _field(
                          widget.lastNameController,
                          "Last Name",
                        ),
                        _field(
                          widget.emailController,
                          "Email",
                        ),
                      ),
                      const SizedBox(height: 15),
                      build3Fields(
                        _field(
                          widget.phoneController,
                          "Phone Number",
                        ),
                        _field(
                          widget.roleController,
                          "Role",
                        ),
                        _field(
                          widget.departmentController,
                          "Department",
                        ),
                      ),
                      const SizedBox(height: 15),
                      build3Fields(
                        _field(
                          widget.designationController,
                          "Designation",
                        ),
                        _field(
                          widget.joiningDateController,
                          "Joining Date",
                        ),
                        const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Cancel
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        label: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          DefaultTabController.of(context)
                          .animateTo(1);
                        },
                        child: const Text(
                          "Save & Next",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget build3Fields(
    Widget one,
    Widget two,
    Widget three,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: one),
        const SizedBox(width: 15),
        Expanded(child: two),
        const SizedBox(width: 15),
        Expanded(child: three),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
  ) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _stepTile(
    String number,
    String title,
    bool active,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: active
        ? Colors.orange.withValues(alpha: 0.1)
        : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: active
          ? Colors.orange
          : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor:
            active ? Colors.orange : Colors.grey,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
