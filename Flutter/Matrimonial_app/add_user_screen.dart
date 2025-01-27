import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';
import 'package:flutterbasic/Matrimonial/user_list_screen.dart';
import 'package:intl/intl.dart';

class AddEditUserScreen extends StatefulWidget {
  final User userInstance;
  AddEditUserScreen({Key? key, required this.userInstance}) : super(key: key);

  @override
  _AddEditUserScreenState createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();


  String? _gender;
  List<String> _hobbies = [];
  final List<String> _genderOptions = ['Male', 'Female',];
  final List<String> _hobbyOptions = ['Reading', 'Traveling', 'Music', 'Sports', 'Gaming'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B3A4B), Color(0xFF2E5568), Color(0xFF3F7185)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
            title: const Text(
              'Add User',
              style: TextStyle(
                fontFamily: 'Montserrat', // Elegant font
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Full Name
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid full name (3-50 characters, alphabets only).';
                    }
                    if (!RegExp(r"^[a-zA-Z\s'-]{3,50}").hasMatch(value)) {
                      return 'Enter a valid full name.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // Email Address
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid email address.';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                      return 'Enter a valid email address.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                 // Mobile Number
                TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid 10-digit mobile number.';
                    }
                    if (!RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)) {
                      return 'Enter a valid mobile number.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // Date of Birth
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth (DD/MM/YYYY)'),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1940),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select a valid date of birth.';
                    }
                    DateTime? dob = DateFormat('dd/MM/yyyy').parse(value, true);
                    int age = DateTime.now().year - dob.year;
                    if (age < 18 || age > 80) {
                      return 'You must be between 18 and 80 years old.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // City
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your city.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // Gender
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(labelText: 'Gender'),
                  items: _genderOptions.map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select your gender.';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.0),

                // Hobbies
                Wrap(
                  spacing: 8.0,
                  children: _hobbyOptions.map((hobby) {
                    return ChoiceChip(
                      label: Text(hobby),
                      selected: _hobbies.contains(hobby),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _hobbies.add(hobby);
                          } else {
                            _hobbies.remove(hobby);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                SizedBox(height: 20.0),
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.userInstance.add_User(
                            _fullNameController.text,
                            _emailController.text,
                            _mobileController.text,
                            _dobController.text,
                            _cityController.text,
                            _gender ?? '',
                            _hobbies,
                        );
                        Navigator.pop(context);
                        // Submit the form
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form submitted successfully!')),
                        );
                      }
                    },
                    child: Text('Submit'),
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
