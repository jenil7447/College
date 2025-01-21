import 'package:flutter/material.dart';

class User {
  List<Map<String, dynamic>> userDetail = [];

  // Adding user
  void add_User(String name, String mail, int age) {
    Map<String, dynamic> map = {};
    map['Name'] = name;
    map['Age'] = age;
    map['Email'] = mail;
    userDetail.add(map);
  }

  // Update user
  void update_user(String name, String mail, int age, int idx) {
    Map<String, dynamic> map = {};
    map['Name'] = name;
    map['Age'] = age;
    map['Email'] = mail;
    userDetail[idx] = map;
  }

  // Delete user
  void delete_user(int idx) {
    userDetail.removeAt(idx);
  }

  // Get all user details
  List<Map<String, dynamic>> getUser_details() {
    return userDetail;
  }
}

void main() {
  runApp(MyCrud());
}

class MyCrud extends StatefulWidget {
  const MyCrud({Key? key}) : super(key: key);

  @override
  State<MyCrud> createState() => _MyCrudState();
}

class _MyCrudState extends State<MyCrud> {
  User userlist1 = User();
  var name = TextEditingController();
  var mail = TextEditingController();
  var age = TextEditingController();
  var searchController = TextEditingController();
  bool isEditing = false;
  int? editingIndex;
  List<Map<String, dynamic>> filteredUsers = [];

  @override
  void initState() {
    super.initState();
    filteredUsers = userlist1.getUser_details();
    searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterUsers);
    searchController.dispose();
    super.dispose();
  }

  // Function to filter users based on search input
  void _filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = userlist1
          .getUser_details()
          .where((user) =>
      user['Name'].toLowerCase().contains(query) ||
          user['Email'].toLowerCase().contains(query) ||
          user['Age'].toString().contains(query))
          .toList();
    });
  }

  // Function to add or update user
  void _addOrUpdateUser() {
    if (name.text.isNotEmpty && mail.text.isNotEmpty && age.text.isNotEmpty) {
      if (isEditing) {
        userlist1.update_user(name.text, mail.text, int.parse(age.text), editingIndex!);
        setState(() {
          isEditing = false; // Reset editing mode
          editingIndex = null;
        });
      } else {
        userlist1.add_User(name.text, mail.text, int.parse(age.text));
      }

      setState(() {
        filteredUsers = userlist1.getUser_details(); // Refresh filtered list
      });

      // Clear the text fields
      name.clear();
      mail.clear();
      age.clear();
    }
  }

  // Function to start editing a user
  void _startEditing(int index) {
    setState(() {
      isEditing = true;
      editingIndex = index;
      name.text = filteredUsers[index]['Name'];
      mail.text = filteredUsers[index]['Email'];
      age.text = filteredUsers[index]['Age'].toString();
    });
  }

  // Function to delete user
  void _deleteUser(int index) {
    int originalIndex = userlist1.getUser_details().indexOf(filteredUsers[index]);
    userlist1.delete_user(originalIndex);
    setState(() {
      filteredUsers = userlist1.getUser_details(); // Refresh filtered list
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("CRUD App"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search bar
              _buildTextField(searchController, 'Search by Name, Email, or Age'),
              SizedBox(height: 10),
              // TextFields for adding or editing user
              _buildTextField(name, 'Name'),
              SizedBox(height: 10),
              _buildTextField(mail, 'Email'),
              SizedBox(height: 10),
              _buildTextField(age, 'Age', keyboardType: TextInputType.number),
              SizedBox(height: 20),
              // Add or Update button
              ElevatedButton(
                onPressed: _addOrUpdateUser,
                child: Text(isEditing ? 'Update User' : 'Add User'),
              ),
              SizedBox(height: 20),
              // Displaying users and editing them directly
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    return _buildUserItem(context, user, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  // Helper method to build a user item widget
  Widget _buildUserItem(BuildContext context, Map<String, dynamic> user, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(user['Name']),
        subtitle: Text('Email: ${user['Email']}\nAge: ${user['Age']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit user
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _startEditing(index); // Start editing this user
              },
            ),
            // Delete user
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteUser(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
