import 'package:flutter/material.dart';

class EducationTab extends StatelessWidget {

  final TextEditingController tenthSchoolController;
  final TextEditingController tenthBoardController;
  final TextEditingController tenthPercentageController;
  final TextEditingController tenthYearController;

  final TextEditingController twelfthSchoolController;
  final TextEditingController twelfthBoardController;
  final TextEditingController twelfthPercentageController;
  final TextEditingController twelfthYearController;

  final TextEditingController diplomaCourseController;
  final TextEditingController diplomaCollegeController;
  final TextEditingController diplomaUniversityController;
  final TextEditingController diplomaPercentageController;
  final TextEditingController diplomaYearController;

  final TextEditingController ugDegreeController;
  final TextEditingController ugDepartmentController;
  final TextEditingController ugCollegeController;
  final TextEditingController ugUniversityController;
  final TextEditingController ugPercentageController;
  final TextEditingController ugYearController;

  final TextEditingController pgDegreeController;
  final TextEditingController pgSpecializationController;
  final TextEditingController pgCollegeController;
  final TextEditingController pgUniversityController;
  final TextEditingController pgPercentageController;
  final TextEditingController pgYearController;

  const EducationTab({
    super.key,
    required this.tenthSchoolController,
    required this.tenthBoardController,
    required this.tenthPercentageController,
    required this.tenthYearController,

    required this.twelfthSchoolController,
    required this.twelfthBoardController,
    required this.twelfthPercentageController,
    required this.twelfthYearController,

    required this.diplomaCourseController,
    required this.diplomaCollegeController,
    required this.diplomaUniversityController,
    required this.diplomaPercentageController,
    required this.diplomaYearController,

    required this.ugDegreeController,
    required this.ugDepartmentController,
    required this.ugCollegeController,
    required this.ugUniversityController,
    required this.ugPercentageController,
    required this.ugYearController,

    required this.pgDegreeController,
    required this.pgSpecializationController,
    required this.pgCollegeController,
    required this.pgUniversityController,
    required this.pgPercentageController,
    required this.pgYearController,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> tenthBoards = [
      "State Board",
      "CBSE",
      "ICSE",
      "Matriculation",
      "NIOS",
      "Other",
    ];
    final List<String> twelfthBoards = [
      "State Board",
      "CBSE",
      "ICSE",
      "Matriculation",
      "NIOS",
      "Other",
    ];
    final List<String> diplomaCourses = [
      "Diploma Mechanical",
      "Diploma Civil",
      "Diploma ECE",
      "Diploma EEE",
      "Diploma CSE",
      "Diploma IT",
      "Other",
    ];
    final List<String> ugDegrees = [
      "B.E",
      "B.Tech",
      "B.Sc",
      "BCA",
      "B.Com",
      "BBA",
      "BA",
      "Other",
    ];
    final List<String> ugDepartments = [
      "Computer Science",
      "Information Technology",
      "Mechanical",
      "Civil",
      "ECE",
      "EEE",
      "AI & DS",
      "Cyber Security",
      "Commerce",
      "Management",
      "Other",
    ];
    final List<String> pgDegrees = [
      "M.E",
      "M.Tech",
      "M.Sc",
      "MCA",
      "MBA",
      "M.Com",
      "MA",
      "Other",
    ];
    final List<String> pgSpecializations = [
      "Computer Science",
      "Information Technology",
      "Finance",
      "Marketing",
      "HR",
      "Operations",
      "Data Science",
      "AI",
      "Cyber Security",
      "Other",
    ];
    

    int percentage = 66;

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
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 20),

                _stepTile("1", "Basic", true),
                _stepTile("2", "Personal", true),
                _stepTile("3", "Family", true),
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
              ),

              child: Column(
                children: [

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Education Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  buildSectionTitle("10th Details"),

                  build4Fields(
                    buildField(tenthSchoolController, "School"),
                    buildDropdown(
                      "10th Board",
                      tenthBoardController,
                      tenthBoards,
                    ),
                    buildField(tenthPercentageController, "Percentage"),
                    buildField(tenthYearController, "Passed Out Year"),
                  ),

                  const SizedBox(height: 20),

                  buildSectionTitle("12th Details"),

                  build4Fields(
                    buildField(twelfthSchoolController, "School"),
                    buildDropdown(
                      "12th Board",
                      twelfthBoardController,
                      twelfthBoards,
                    ),
                    buildField(twelfthPercentageController, "Percentage"),
                    buildField(twelfthYearController, "Passed Out Year"),
                  ),

                  const SizedBox(height: 20),

                  buildSectionTitle("Diploma Details"),

                  build4Fields(
                    buildDropdown(
                      "Diploma Course",
                      diplomaCourseController,
                      diplomaCourses,
                    ),
                    buildField(diplomaCollegeController, "College"),
                    buildField(diplomaUniversityController, "University"),
                    buildField(diplomaPercentageController, "Percentage"),
                  ),

                  const SizedBox(height: 15),

                  build4Fields(
                    buildField(diplomaYearController, "Passed Out Year"),
                    const SizedBox(),
                    const SizedBox(),
                    const SizedBox(),
                  ),

                  const SizedBox(height: 20),

                  buildSectionTitle("UG Details"),

                  build4Fields(
                    buildDropdown(
                      "UG Degree",
                      ugDegreeController,
                      ugDegrees,
                    ),
                    buildDropdown(
                      "UG Department",
                      ugDepartmentController,
                      ugDepartments,
                    ),
                    buildField(ugCollegeController, "College"),
                    buildField(ugUniversityController, "University"),
                  ),

                  const SizedBox(height: 15),

                  build4Fields(
                    buildField(ugPercentageController, "Percentage"),
                    buildField(ugYearController, "Passed Out Year"),
                    const SizedBox(),
                    const SizedBox(),
                  ),

                  const SizedBox(height: 20),

                  buildSectionTitle("PG Details"),

                  build4Fields(
                    buildDropdown(
                      "PG Degree",
                      pgDegreeController,
                      pgDegrees,
                    ),
                    buildDropdown(
                      "PG Specialization",
                      pgSpecializationController,
                      pgSpecializations,
                    ),
                    buildField(pgCollegeController, "College"),
                    buildField(pgUniversityController, "University"),
                  ),

                  const SizedBox(height: 15),

                  build4Fields(
                    buildField(pgPercentageController, "Percentage"),
                    buildField(pgYearController, "Passed Out Year"),
                    const SizedBox(),
                    const SizedBox(),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      OutlinedButton.icon(
                        onPressed: () {
                          DefaultTabController.of(context)
                              .animateTo(2);
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
                              .animateTo(4);
                        },
                        child: const Text(
                          "Save & Next",
                          style: TextStyle(color: Colors.white),
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
  Widget build4Fields(
    Widget one,
    Widget two,
    Widget three,
    Widget four,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: one),
          const SizedBox(width: 15),
          Expanded(child: two),
          SizedBox(width: 15),
          Expanded(child: three),
          const SizedBox(width: 15),
          Expanded(child: four),
        ],
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
          ? Colors.orange.withOpacity(0.1)
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
            backgroundColor:active ? Colors.orange : Colors.grey,
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

