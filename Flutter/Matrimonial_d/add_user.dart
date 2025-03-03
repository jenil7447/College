import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbasic/Matrimonial_D/constants/string_constants.dart';
import 'package:intl/intl.dart';
import 'package:flutterbasic/Matrimonial_D/database/matrimony_database.dart';
import 'package:flutterbasic/Matrimonial_D/screens/user_list.dart';
import 'package:sqflite/sqflite.dart';

class AddUser extends StatefulWidget {
  final List<Map<String, dynamic>> userList;
  final int? index;

  const AddUser({super.key, required this.userList, this.index});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  DateTime? selectedDateOfBirth;
  String? selectedCity;
  String? selectedGender;
  bool showGenderError = false;
  bool isReading = false;
  bool isMusic = false;
  bool isMovies = false;
  bool isSports = false;
  bool isExecuted = true;

  @override
  Widget build(BuildContext context) {
    if(widget.index != null && isExecuted) {
      nameController.text = widget.userList[widget.index!][NAME];
      passwordController.text = widget.userList[widget.index!][PASSWORD];
      addressController.text = widget.userList[widget.index!][ADDRESS];
      emailController.text = widget.userList[widget.index!][EMAIL];
      phoneController.text = widget.userList[widget.index!][PHONE];
      selectedDateOfBirth = DateTime.parse(widget.userList[widget.index!][DOB]);
      selectedCity = widget.userList[widget.index!][CITY];
      selectedGender = widget.userList[widget.index!][GENDER];
      if(widget.userList[widget.index!][HOBBIES].contains('Reading')) {
        isReading = true;
      }
      if(widget.userList[widget.index!][HOBBIES].contains('Music')) {
        isMusic = true;
      }
      if(widget.userList[widget.index!][HOBBIES].contains('Movies')) {
        isMovies = true;
      }
      if(widget.userList[widget.index!][HOBBIES].contains('Sports')) {
        isSports = true;
      }
      isExecuted = false;
    }
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(
          color: Colors.white,
        ),
        title: const Text('Add User', style: TextStyle(fontSize: 22)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900, Colors.purple.shade700], // Adjust colors to match the image
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(nameController, 'Name', Icons.person, 'Please enter a name'),
              _buildPasswordField(),
              _buildTextField(addressController, 'Address', Icons.location_on, 'Please enter your address'),
              _buildTextField(emailController, 'Email', Icons.email, 'Please enter a valid email', isEmail: true),
              _buildTextField(phoneController, 'Mobile Number', Icons.phone, 'Enter a valid 10-digit number', isPhone: true),
              _buildDatePicker(context),
              _buildCityDropdown(),
              _buildGenderSelection(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text('Reading'),
                    Checkbox(
                        value: isReading,
                        onChanged: (value) {
                          setState(() {
                            isReading = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text('Music'),
                    Checkbox(
                        value: isMusic,
                        onChanged: (value) {
                          setState(() {
                            isMusic = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text('Movies'),
                    Checkbox(
                        value: isMovies,
                        onChanged: (value) {
                          setState(() {
                            isMovies = value!;
                          });
                        }),
                    SizedBox(width: 4),
                    Text('Sports'),
                    Checkbox(
                        value: isSports,
                        onChanged: (value) {
                          setState(() {
                            isSports = value!;
                          });
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSaveResetButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String validationMsg, {bool isEmail = false, bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : (isPhone ? TextInputType.phone : TextInputType.text),
        inputFormatters: isPhone ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(icon, color: Colors.blueGrey.shade700),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          else if (isEmail) {
            if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
              return 'Enter a valid email address';
            }
            else {
              for (var map in widget.userList) {
                if (map[EMAIL] == value) {
                  if (widget.index != null) {
                    if (map[EMAIL] != widget.userList[widget.index!][EMAIL]) {
                      return 'Email already exists';
                    }
                  }
                  else {
                    return 'Email already exists';
                  }
                }
              }
            }
          }
          else if(isPhone) {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Enter a valid 10-digit mobile number';
            }
            else {
              for (var map in widget.userList) {
                if (map[PHONE] == value) {
                  if (widget.index != null) {
                    if (map[PHONE] != widget.userList[widget.index!][PHONE]) {
                      return 'Mobile number already exists';
                    }
                  }
                  else {
                    return 'Mobile number already exists';
                  }
                }
              }
            }
          }
          return null;
        }
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(Icons.lock, color: Colors.blueGrey.shade700),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          ),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Please enter your password' : null,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    TextEditingController dateController = TextEditingController(
      text: selectedDateOfBirth != null
          ? DateFormat('dd/MM/yyyy').format(selectedDateOfBirth!)
          : '',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: dateController,
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          hintText: 'Pick your date of birth',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.blueGrey.shade700),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDateOfBirth ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );

          if (pickedDate != null) {
            setState(() {
              selectedDateOfBirth = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
              dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          }
        },
        validator: (value) {
          if (selectedDateOfBirth == null) {
            return 'Please select your date of birth';
          }

          final today = DateTime.now();
          final age = today.year - selectedDateOfBirth!.year -
              ((today.month < selectedDateOfBirth!.month ||
                  (today.month == selectedDateOfBirth!.month && today.day < selectedDateOfBirth!.day)) ? 1 : 0);

          if (age < 18) {
            return 'You must be at least 18 years old to register';
          } else if (age > 80) {
            return 'The maximum age allowed is 80 years';
          }
          return null;
        },
      ),
    );
  }


  Widget _buildCityDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedCity,
        items: ['Ahmedabad', 'Rajkot', 'Junagadh', 'Vadodara', 'Surat', 'Jamnagar']
            .map((city) => DropdownMenuItem(value: city, child: Text(city)))
            .toList(),
        onChanged: (value) => setState(() => selectedCity = value),
        decoration: InputDecoration(
          labelText: 'City',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: Icon(Icons.location_city, color: Colors.blueGrey.shade700),
        ),
        validator: (value) => value == null ? 'Please select a city' : null,
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Gender: ', style: TextStyle(fontSize: 16)),
              Radio(
                value: 'Male',
                groupValue: selectedGender,
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              const Text('Male'),
              Radio(
                value: 'Female',
                groupValue: selectedGender,
                onChanged: (value) => setState(() => selectedGender = value),
              ),
              const Text('Female'),
            ],
          ),
          if (showGenderError)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Please select a gender',
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }


  Widget _buildSaveResetButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (selectedGender == null) {
                setState(() {
                  showGenderError = true;
                });
              }
      if (_formKey.currentState!.validate()) {
        if (selectedGender == null) {
          setState(() {
            showGenderError = true;
          });
        } else {
          Map<String, dynamic> map = {};
          final today = DateTime.now();
          final age = today.year -
              selectedDateOfBirth!.year -
              ((today.month < selectedDateOfBirth!.month ||
                  (today.month == selectedDateOfBirth!.month &&
                      today.day < selectedDateOfBirth!.day))
                  ? 1
                  : 0);
          map[NAME] = nameController.text.toString();
          map[PASSWORD] = passwordController.text.toString();
          map[ADDRESS] = addressController.text.toString();
          map[EMAIL] = emailController.text.toString();
          map[PHONE] = phoneController.text.toString();
          map[DOB] = selectedDateOfBirth?.toIso8601String().split('T')[0];
          map[AGE] = age;
          map[CITY] = selectedCity.toString();
          map[GENDER] = selectedGender.toString();
          map[HOBBIES] = '';
          if(widget.index != null) {
            if(widget.userList[widget.index!][FAVOURITE] == 1) {
              map[FAVOURITE] = 1;
            }
            else {
              map[FAVOURITE] = 0;
            }
          }
          else {
            map[FAVOURITE] = 0;
          }
          if (isReading) {
            map[HOBBIES] += 'Reading ';
          }
          if (isMusic) {
            map[HOBBIES] += 'Music ';
          }
          if (isMovies) {
            map[HOBBIES] += 'Movies ';
          }
          if (isSports) {
            map[HOBBIES] += 'Sports ';
          }
          if(widget.index != null) {
            print("Updating user at index: ${widget.index}");

            int? id = await MatrimonyDatabase().getId(widget.userList[widget.index!][EMAIL]);
            MatrimonyDatabase().updateUser(id, map);
            print("User updated in the database.");

            widget.userList[widget.index!] = map;
            print("User list updated: ${widget.userList}");

            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User Saved")));
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserList(userList: widget.userList, isFavourite: false,),));
            });
          }
          else {
            print("Adding a new user.");

            MatrimonyDatabase().addUser(map);
            print("New user added to the database.");

            widget.userList.add(map);
            print("User list after adding: ${widget.userList}");

            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User Saved")));
              Navigator.pop(context);
            });
          }
          // setState(() async {
          //   if(widget.index != null) {
          //     int id = await MatrimonyDatabase().getId(map[EMAIL]);
          //     MatrimonyDatabase().updateUser(id, map);
          //     widget.userList[widget.index!] = map;
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text("User Saved")));
          //     Navigator.pop(context);
          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserList(userList: widget.userList, isFavourite: false,),));
          //   }
          //   else {
          //     MatrimonyDatabase().addUser(map);
          //     widget.userList.clear();
          //     widget.userList.add(map);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text("User Saved")));
          //     Navigator.pop(context);
          //   }
          // });
        }
      }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green,),
            child: const Text('Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                nameController.text = '';
                passwordController.text = '';
                addressController.text = '';
                emailController.text = '';
                phoneController.text = '';
                selectedDateOfBirth = null;
                selectedCity = null;
                selectedGender = null;
                isReading = false;
                isMusic = false;
                isMovies = false;
                isSports = false;
                showGenderError = false;
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
