import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';

class AddProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final int? userIndex;
  AddProfileScreen({this.userData, this.userIndex});
  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? _selectedCity;
  String? _selectedGender;
  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _dobError;
  String? _genderError;
  String? _hobbiesError;
  String? _cityError;
  List<String> _selectedHobbies = [];
  final List<String> _hobbies = ['Reading', 'Traveling', 'Music', 'Sports'];
  final List<String> _cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Miami'];

  InputDecoration _inputDecoration(String label, IconData icon, String? errorText) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      errorText: errorText,
    );
  }

  void _validateName(String value) {
    setState(() {
      _nameError = RegExp(r"^[a-zA-Z\s'-]{3,50}$").hasMatch(value)
          ? null
          : "Enter a valid full name (3-50 characters, alphabets only)";
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _emailError = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)
          ? null
          : "Enter a valid email address";
    });
  }

  void _validateMobile(String value) {
    setState(() {
      _mobileError = RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)
          ? null
          : "Enter a valid 10-digit mobile number";
    });
  }


  void _validateDOB() {
    setState(() {
      if (_dobController.text.isNotEmpty) {
        DateTime? dob = DateFormat('dd/MM/yyyy').parse(_dobController.text, true);
        DateTime now = DateTime.now();
        int age = now.year - dob.year;
        if (dob.month > now.month || (dob.month == now.month && dob.day > now.day)) {
          age--;
        }
        _dobError = (age >= 18 && age <= 80) ? null : "You must be at least 18 years old to register";
      } else {
        _dobError = "Date of Birth is required";
      }
    });
  }

  void _validateGender() {
    setState(() {
      _genderError = _selectedGender == null ? "Please select your gender" : null;
    });
  }

  void _validateHobbies() {
    setState(() {
      _hobbiesError = _selectedHobbies.isEmpty ? "Select at least one hobby" : null;
    });
  }

  void _validateCity() {
    setState(() {
      _cityError = _selectedCity == null ? "Please select a city" : null;
    });
  }

  bool _validateForm() {
    _validateName(_nameController.text);
    _validateEmail(_emailController.text);
    _validateMobile(_mobileController.text);
    _validateDOB();
    _validateGender();
    _validateHobbies();
    _validateCity();
    return _nameError == null &&
        _emailError == null &&
        _mobileError == null &&
        _dobError == null &&
        _genderError == null &&
        _hobbiesError == null &&
        _cityError == null;
  }
  @override
  void initState() {
    super.initState();
    if (widget.userData != null) {
      _nameController.text = widget.userData!["fullName"];
      _emailController.text = widget.userData!["email"];
      _mobileController.text = widget.userData!["mobile"];
      _dobController.text = widget.userData!["dob"];
      _selectedCity = widget.userData!["city"];
      _selectedGender = widget.userData!["gender"];
      _selectedHobbies = List<String>.from(widget.userData!["hobbies"]);
    }
  }
  void _submitForm() {
    if (_validateForm()) {
      if (_formKey.currentState!.validate()) {
        bool isSuccess;
        if (widget.userIndex != null) {
          UserCrud.updateUser(widget.userIndex!,
            _nameController.text,
            _emailController.text,
            _mobileController.text,
            _dobController.text,
            _selectedCity!,
            _selectedGender!,
            _selectedHobbies,);
          isSuccess = true;
          print('Data updated in the list');

        } else {
          UserCrud.addUser(
            _nameController.text,
            _emailController.text,
            _mobileController.text,
            _dobController.text,
            _selectedCity!,
            _selectedGender!,
            _selectedHobbies,
          );
          print("Data add in the list");
          isSuccess = true;
        }
        if (isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.userIndex != null ? 'User updated successfully!' : 'User added successfully!')),
          );
          Navigator.pop(context, true); // Close the form and return true
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update/add user. Please try again.')),
          );
        }
      }
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration('Full Name', Icons.person, _nameError),
                  keyboardType: TextInputType.name,
                  onChanged: _validateName,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration('Email Address', Icons.email, _emailError),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _validateEmail,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _mobileController,
                  decoration: _inputDecoration('Mobile Number', Icons.phone, _mobileError),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: _validateMobile,
                ),
                SizedBox(height: 10),
              TextFormField(
                controller: _dobController,
                decoration: _inputDecoration('Date of Birth', Icons.calendar_today, _dobError),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (pickedDate != null) {
                    _dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                  }
                  _validateDOB();
                },
              ),

                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: _inputDecoration('Select City', Icons.location_city, _cityError),
                  value: _selectedCity,
                  items: _cities.map((city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedCity = value),
                ),
                SizedBox(height: 10),
                Text("Gender: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio(value: "Male", groupValue: _selectedGender, onChanged: (value) => setState(() => _selectedGender = value.toString())),
                    Text("Male"),
                    Radio(value: "Female", groupValue: _selectedGender, onChanged: (value) => setState(() => _selectedGender = value.toString())),
                    Text("Female"),
                  ],
                ),
                if (_genderError != null) Text(_genderError!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),
                Text("Hobbies:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8.0,
                  children: _hobbies.map((hobby) {
                    return ChoiceChip(
                      label: Text(hobby),
                      selected: _selectedHobbies.contains(hobby),
                      onSelected: (selected) => setState(() => selected ? _selectedHobbies.add(hobby) : _selectedHobbies.remove(hobby)),
                    );
                  }).toList(),
                ),
                if (_hobbiesError != null) Text(_hobbiesError!, style: TextStyle(color: Colors.red)),
                SizedBox(height: 10),
                ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
