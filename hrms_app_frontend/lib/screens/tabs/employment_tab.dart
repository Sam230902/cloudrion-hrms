import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmploymentTab extends StatefulWidget {
  final TextEditingController companyNameController;
  final TextEditingController designationController;
  final TextEditingController departmentController;
  final TextEditingController employmentTypeController;
  final TextEditingController workLocationController;
  final TextEditingController joiningDateController;
  final TextEditingController relievingDateController;
  final TextEditingController noticePeriodController;
  final TextEditingController previousCtcController;
  final TextEditingController currentCtcController;
  final TextEditingController expectedCtcController;

  const EmploymentTab({
    super.key,
    required this.companyNameController,
    required this.designationController,
    required this.departmentController,
    required this.employmentTypeController,
    required this.workLocationController,
    required this.joiningDateController,
    required this.relievingDateController,
    required this.noticePeriodController,
    required this.previousCtcController,
    required this.currentCtcController,
    required this.expectedCtcController,
  });

  @override
  State<EmploymentTab> createState() => _EmploymentTabState();
}

class _EmploymentTabState extends State<EmploymentTab> {

  int percentage = 83;

  final List<String> departments = [
    "HR",
    "IT",
    "Finance",
    "Accounts",
    "Sales",
    "Marketing",
    "Operations",
    "Production",
    "Support",
  ];

  final List<String> designations = [
    "Trainee",
    "Junior Developer",
    "Software Engineer",
    "Senior Software Engineer",
    "Team Lead",
    "Manager",
    "HR Executive",
    "HR Manager",
    "Accountant",
  ];

  final List<String> employmentTypes = [
    "Permanent",
    "Contract",
    "Internship",
    "Part Time",
    "Consultant",
  ];

  final List<String> locations = [
    "Chennai",
    "Coimbatore",
    "Madurai",
    "Trichy",
    "Salem",
    "Bangalore",
    "Hyderabad",
    "Remote",
  ];
  Future<void> pickDate(
    TextEditingController controller,
  ) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =DateFormat("dd-MM-yyyy").format(picked);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// LEFT PANEL
          Container(
            width: 280,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
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
                          value: percentage / 100,
                          strokeWidth: 12,
                          color: Colors.green,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),

                      Text(
                        "$percentage%",
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
                  "$percentage% Completed",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _stepTile("1", "Basic", true),
                _stepTile("2", "Personal", true),
                _stepTile("3", "Family", true),
                _stepTile("4", "Education", true),
                _stepTile("5", "Employment", true),
                _stepTile("6", "Projects", false),
              ],
            ),
          ),

          const SizedBox(width: 20),

          /// RIGHT PANEL
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Employment Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  buildSectionTitle(
                    "Employment Details"
                  ),
                  build3Fields(
                    buildField(
                      widget.companyNameController,
                      "Company Name",
                    ),
                    buildDropdown(
                      "Designation",
                      widget.designationController,
                      designations,
                    ),
                    buildDropdown(
                      "Department",
                      widget.departmentController,
                      departments,
                    ),
                  ),
                  const SizedBox(height: 15),
                  build3Fields(
                    buildDropdown(
                      "Employment Type",
                      widget.employmentTypeController,
                      employmentTypes,
                    ),
                    buildField(
                      widget.workLocationController,
                      "Work Location",
                    ),
                    buildDateField(
                      "Joining Date",
                      widget.joiningDateController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSectionTitle(
                    "Salary Information"
                  ),
                  build3Fields(
                    buildField(
                      widget.previousCtcController,
                      "Previous CTC",
                    ),
                    buildField(
                      widget.currentCtcController,
                      "Current CTC",
                    ),
                    buildField(
                      widget.expectedCtcController,
                      "Expected CTC",
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildSectionTitle("Exit Information"),
                  build3Fields(
                    buildDateField(
                      "Relieving Date",
                      widget.relievingDateController,
                    ),
                    buildField(
                      widget.noticePeriodController,
                      "Notice Period (Days)",
                    ),
                    const SizedBox(),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      OutlinedButton.icon(
                        onPressed: () {
                          DefaultTabController.of(context)
                              .animateTo(3);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                      ),

                      const SizedBox(width: 15),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          DefaultTabController.of(context)
                              .animateTo(5);
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
  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
  Widget buildDateField(
    String label,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => pickDate(controller),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.calendar_month),
      ),
    );
  }

  Widget buildField(
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

  Widget buildDropdown(
    String label,
    TextEditingController controller,
    List<String> items,
  ) {
    return DropdownButtonFormField<String>(
      value: controller.text.isEmpty ? null : controller.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) {
        controller.text = value ?? "";
      },
    );
  }

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

          Expanded(
            child: Text(title),
          ),
        ],
      ),
    );
  }
}