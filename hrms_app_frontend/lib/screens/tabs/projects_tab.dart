import 'package:flutter/material.dart';

class ProjectsTab extends StatefulWidget {
  final VoidCallback onFinish;
  final TextEditingController projectNameController;
  final TextEditingController clientNameController;
  final TextEditingController projectDurationController;
  final TextEditingController roleInProjectController;
  final TextEditingController technologiesUsedController;
  final TextEditingController projectDescriptionController;

  const ProjectsTab({
    super.key,
    required this.onFinish,
    required this.projectNameController,
    required this.clientNameController,
    required this.projectDurationController,
    required this.roleInProjectController,
    required this.technologiesUsedController,
    required this.projectDescriptionController,
  });

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  int percentage = 100;

  @override
  Widget build(BuildContext context) {
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
                          value: percentage / 100,
                          strokeWidth: 12,
                          color: Colors.green,
                          backgroundColor: Colors.grey,
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

                const Text(
                  "100% Completed",
                  style: TextStyle(
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
                _stepTile("6", "Projects", true),
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
                      "Project Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  build3Fields(
                    buildField(
                      widget.projectNameController,
                      "Project Name",
                    ),
                    buildField(
                      widget.clientNameController,
                      "Client Name",
                    ),
                    buildField(
                      widget.projectDurationController,
                      "Project Duration",
                    ),
                  ),

                  const SizedBox(height: 15),

                  build3Fields(
                    buildField(
                      widget.roleInProjectController,
                      "Role In Project",
                    ),
                    buildField(
                      widget.technologiesUsedController,
                      "Technologies Used",
                    ),
                    const SizedBox(),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller:
                        widget.projectDescriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: "Project Description",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      OutlinedButton.icon(
                        onPressed: () {
                          DefaultTabController.of(context)
                              .animateTo(4);
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                      ),

                      const SizedBox(width: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: widget.onFinish,
                        child: const Text(
                          "Finish",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
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

          Expanded(
            child: Text(title),
          ),
        ],
      ),
    );
  }
}