import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';
import 'package:intl/intl.dart';

class AddEditUserScreen extends StatefulWidget {
  final User userInstance;
  final Map<String, dynamic>? user;
  final int? index;

  AddEditUserScreen({Key? key, this.user, this.index, required this.userInstance}) : super(key: key);

  @override
  _AddEditUserScreenState createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String? _gender;
  List<String> _hobbies = [];
  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _hobbyOptions = ['Reading', 'Traveling', 'Music', 'Sports', 'Gaming', 'Watching Movies'];

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _fullNameController.text = widget.user!['fullName'] ?? '';
      _emailController.text = widget.user!['email'] ?? '';
      _mobileController.text = widget.user!['mobile'] ?? '';
      _dobController.text = widget.user!['dob'] ?? '';
      _cityController.text = widget.user!['city'] ?? '';
      _gender = widget.user!['gender'] ?? null;
      _hobbies = List<String>.from(widget.user!['hobbies'] ?? []);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user != null ? 'Edit User' : 'Add User'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: _inputDecoration('Full Name'),
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration('Email Address'),
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _mobileController,
                  decoration: _inputDecoration('Mobile Number'),
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _dobController,
                  decoration: _inputDecoration('Date of Birth (DD/MM/YYYY)'),
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
                      return 'Please select a valid date of birth.';
                    }
                    try {
                      DateTime dob = DateFormat('dd/MM/yyyy').parseStrict(value);
                      int age = DateTime.now().year - dob.year;
                      if (age < 18 || age > 80) {
                        return 'You must be between 18 and 80 years old.';
                      }
                    } catch (e) {
                      return 'Invalid date format. Please use DD/MM/YYYY.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: _inputDecoration('City'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your city.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: _inputDecoration('Gender'),
                  items: _genderOptions.map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) => setState(() => _gender = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select your gender.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: _hobbyOptions.map((hobby) {
                    return ChoiceChip(
                      label: Text(hobby),
                      selected: _hobbies.contains(hobby),
                      selectedColor: Colors.blueGrey,
                      onSelected: (selected) {
                        setState(() {
                          selected ? _hobbies.add(hobby) : _hobbies.remove(hobby);
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.user != null && widget.index != null) {
                          widget.userInstance.update_user(
                            _fullNameController.text,
                            _emailController.text,
                            _mobileController.text,
                            _dobController.text,
                            _cityController.text,
                            _gender ?? '',
                            _hobbies,
                            widget.index!,
                          );
                        } else {
                          widget.userInstance.add_User(
                            _fullNameController.text,
                            _emailController.text,
                            _mobileController.text,
                            _dobController.text,
                            _cityController.text,
                            _gender ?? '',
                            _hobbies,
                          );
                        }
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(widget.user != null ? 'Update' : 'Submit'),
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
