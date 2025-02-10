import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';


class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String searchQuery = "";

  void _refreshScreen() {
    setState(() {});
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              UserCrud.deleteUser(index);
              _refreshScreen();
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editUser(int index) {
    final user = UserCrud.userDetails[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProfileScreen(userData: user, userIndex: index),
      ),
    ).then((_) => _refreshScreen());
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = UserCrud.userDetails.where((user) {
      return user["fullName"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search people & places",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(child: Text("No users available"))
                : ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.pink[100],
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user["fullName"],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Divider(thickness: 1, color: Colors.grey[300]),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                user["isFavorite"] ? Icons.favorite : Icons.favorite_border,
                                color: user["isFavorite"] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                UserCrud.toggleFavorite(index);
                                _refreshScreen();
                              },
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == "edit") {
                                  _editUser(index);
                                } else if (value == "delete") {
                                  _showDeleteDialog(index);
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(value: "edit", child: Text("Edit")),
                                PopupMenuItem(value: "delete", child: Text("Delete")),
                              ],
                              icon: Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.orange, size: 16),
                            SizedBox(width: 5),
                            Text(user["city"]),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green, size: 16),
                            SizedBox(width: 5),
                            Text(user["mobile"]),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.red, size: 16),
                            SizedBox(width: 5),
                            Text(user["email"]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
