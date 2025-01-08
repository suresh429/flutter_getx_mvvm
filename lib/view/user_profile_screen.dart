import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  // void _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
  //     });
  //   }
  // }
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color, including past dates
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image with Edit Option
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      AssetImage('assets/profile_placeholder.png'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Handle profile image edit action
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Add Two Rows Below the Image View
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      "User Info Row 1",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.email, color: Colors.grey),
                    const SizedBox(width: 10),
                    Text(
                      "User Info Row 2",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Text Fields
                _buildTextField(label: "First Name"),
                _buildTextField(label: "Last Name"),
                _buildDateOfBirthField(context),
                _buildGenderDropdown(),
                _buildTextField(label: "Username"),
                _buildTextField(
                    label: "Email", keyboardType: TextInputType.emailAddress),
                _buildTextField(
                    label: "Phone Number", keyboardType: TextInputType.phone),
                _buildTextField(label: "Location"),
                const SizedBox(height: 20),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile Updated')),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String label, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _dobController,
        readOnly: true,
        style: const TextStyle(color: Colors.black), // Calendar text in black
        decoration: InputDecoration(
          labelText: "Date of Birth",
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your Date of Birth';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Gender",
          border: OutlineInputBorder(),
        ),
        value: _selectedGender,
        items: ["Male", "Female", "Other"]
            .map((gender) => DropdownMenuItem(
          value: gender,
          child: Text(gender),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedGender = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your Gender';
          }
          return null;
        },
      ),
    );
  }
}
