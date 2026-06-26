import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalTab extends StatefulWidget {
  final TextEditingController dobController;
  final TextEditingController ageController;
  final TextEditingController bloodGroupController;
  final TextEditingController genderController;
  final TextEditingController maritalStatusController;
  final TextEditingController religionController;
  final TextEditingController nationalityController;
  final TextEditingController nativeStateController;
  final TextEditingController districtController;
  final TextEditingController panNumberController;
  final TextEditingController passportNumberController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController permanentAddressController;
  final TextEditingController pincodeController;

  const PersonalTab({
    super.key,
    required this.dobController,
    required this.ageController,
    required this.bloodGroupController,
    required this.genderController,
    required this.maritalStatusController,
    required this.religionController,
    required this.nationalityController,
    required this.nativeStateController,
    required this.districtController,
    required this.panNumberController,
    required this.passportNumberController,
    required this.heightController,
    required this.weightController,
    required this.permanentAddressController,
    required this.pincodeController,
  });

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {

  int percentage = 33;

  final List<String> bloodGroups = [
    "A+","A-","B+","B-","AB+","AB-","O+","O-"
  ];

  final List<String> genders = [
    "Male",
    "Female",
    "Other"
  ];

  final List<String> maritalStatusList = [
    "Single",
    "Married",
    "Divorced",
    "Widowed"
  ];

  final List<String> religions = [
    "Hindu",
    "Christian",
    "Muslim",
    "Sikh",
    "Buddhist",
    "Jain",
    "Other"
  ];

  final List<String> nationalities = [
    "Indian",
    "American",
    "Canadian",
    "Australian",
    "Singaporean"
  ];

  final List<String> states = [
    "Tamil Nadu",
    "Kerala",
    "Karnataka",
    "Andhra Pradesh",
    "Telangana",
    "Maharashtra",
    "Gujarat",
    "Delhi"
  ];
  final List<String>district=[
    "Ariyalur",
    "Chengalpattu",
    "Chennai",
    "Coimbatore",
    "Cuddalore",
    "Dharmapuri",
    "Dindigul",
    "Erode",
    "Kallakurichi",
    "Kanchipuram",
    "Kanyakumari",
    "Karur",
    "Krishnagiri",
    "Madurai",
    "Mayiladuthurai",
    "Nagapattinam",
    "Namakkal",
    "Nilgiris",
    "Perambalur",
    "Pudukkottai",
    "Ramanathapuram",
    "Ranipet",
    "Salem",
    "Sivaganga",
    "Tenkasi",
    "Thanjavur",
    "Theni",
    "Thoothukudi",
    "Tiruchirappalli",
    "Tirunelveli",
    "Tirupathur",
    "Tiruppur",
    "Tiruvallur",
    "Tiruvannamalai",
    "Tiruvarur",
    "Vellore",
    "Viluppuram",
    "Virudhunagar",
    "Others",
  ];

  Future<void> pickDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null) {

      widget.dobController.text =
          DateFormat("dd-MM-yyyy").format(picked);

      int age = DateTime.now().year - picked.year;

      if (DateTime.now().month < picked.month ||
          (DateTime.now().month == picked.month &&
              DateTime.now().day < picked.day)) {
        age--;
      }

      widget.ageController.text = age.toString();

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
                          value:percentage / 100,
                          strokeWidth: 12,
                          color: Colors.green,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(height: 20),
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
              ),

              child: Column(
                children: [

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  build3Fields(
                    buildDOBField(),
                    buildField(
                      widget.ageController,
                      "Age",
                      readOnly: true,
                    ),
                    buildDropdown(
                      "Blood Group",
                      widget.bloodGroupController,
                      bloodGroups,
                    ),
                  ),

                  const SizedBox(height: 15),

                  build3Fields(
                    buildDropdown(
                      "Gender",
                      widget.genderController,
                      genders,
                    ),
                    buildDropdown(
                      "Marital Status",
                      widget.maritalStatusController,
                      maritalStatusList,
                    ),
                    buildDropdown(
                      "Religion",
                      widget.religionController,
                      religions,
                    ),
                  ),

                  const SizedBox(height: 15),

                  build3Fields(
                    buildDropdown(
                      "Nationality",
                      widget.nationalityController,
                      nationalities,
                    ),
                    buildDropdown(
                      "Native State",
                      widget.nativeStateController,
                      states,
                    ),
                     buildDropdown(
                      "District",
                      widget.districtController,
                      district,
                      
                    ),
                  ),
                  const SizedBox(height: 15),

                  build3Fields(
                    buildField(
                      widget.panNumberController,
                      "PAN Number",
                    ),
                    buildField(
                      widget.passportNumberController,
                      "Passport Number",
                    ),
                    buildField(
                      widget.heightController,
                      "Height (cm)",
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: buildField(
                          widget.weightController,
                          "Weight (kg)",
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextFormField(
                          controller: widget.permanentAddressController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: "Permanent Address",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: buildField(
                          widget.pincodeController,
                          "Pincode",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      OutlinedButton.icon(
                        onPressed: () {
                          DefaultTabController.of(context)
                              .animateTo(0);
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
                              .animateTo(2);
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

  Widget buildDOBField() {
    return TextFormField(
      controller: widget.dobController,
      readOnly: true,
      onTap: pickDob,
      decoration: const InputDecoration(
        labelText: "Date Of Birth",
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_month),
      ),
    );
  }

  Widget buildField(
    TextEditingController controller,
    String label, {
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
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
      value: controller.text.isEmpty
          ? null
          : controller.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
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