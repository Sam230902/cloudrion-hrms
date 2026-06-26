import 'package:flutter/material.dart';

class FamilyTab extends StatelessWidget {
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;
  final TextEditingController spouseNameController;
  final TextEditingController childrenCountController;
  final TextEditingController emergencyContactNameController;
  final TextEditingController emergencyContactNumberController;
  final TextEditingController relationshipController;
  final TextEditingController occupationController;

  const FamilyTab({
    super.key,
    required this.fatherNameController,
    required this.motherNameController,
    required this.spouseNameController,
    required this.childrenCountController,
    required this.emergencyContactNameController,
    required this.emergencyContactNumberController,
    required this.relationshipController,
    required this.occupationController,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> relationshipList = [
      'Father',
      'Mother',
      'Husband',
      'Wife',
      'Son',
      'Daughter',
      'Brother',
      'Sister',
      'Grandfather',
      'Grandmother',
      'Uncle',
      'Aunt',
      'Nephew',
      'Niece',
      'Father-in-Law',
      'Mother-in-Law',
      'Brother-in-Law',
      'Sister-in-Law',
      'Guardian',
      'Other',
    ];

    int percentage = 50;

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
                      "Family Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  build3Fields(
                    buildField(
                      fatherNameController,
                      "Father Name",
                    ),
                    buildField(
                      motherNameController,
                      "Mother Name",
                    ),
                    buildField(
                      spouseNameController,
                      "Spouse Name",
                    ),
                  ),

                  const SizedBox(height: 15),

                  build3Fields(
                    buildField(
                      childrenCountController,
                      "Children Count",
                    ),
                    buildField(
                      emergencyContactNameController,
                      "Emergency Contact Name",
                    ),
                    buildField(
                      emergencyContactNumberController,
                      "Emergency Contact Number",
                    ),
                  ),

                  const SizedBox(height: 15),

                  build3Fields(
                    buildDropdown(
                      "Relationship",
                      relationshipController,
                      relationshipList,
                    ),
                    buildField(
                      occupationController,
                      "Occupation",
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
                              .animateTo(1);
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
                              .animateTo(3);
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
            ? Colors.orange.withOpacity(0.1)
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
          Expanded(child: Text(title)),
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
      value: controller.text.isEmpty
        ? null
        : controller.text,
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
}

