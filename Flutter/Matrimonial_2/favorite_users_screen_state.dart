import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';

class FavoriteUserScreen extends StatefulWidget {
  @override
  _FavoriteUserScreenState createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> {
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
    List<Map<String, dynamic>> favoriteUsers = UserCrud.getFavoriteUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Users"),
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favoriteUsers.isEmpty
          ? Center(child: Text("No favorite users available"))
          : ListView.builder(
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          final user = favoriteUsers[index];
          int originalIndex = UserCrud.userDetails.indexOf(user);
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
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          UserCrud.toggleFavorite(originalIndex);
                          _refreshScreen();
                        },
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == "edit") {
                            _editUser(originalIndex);
                          } else if (value == "delete") {
                            _showDeleteDialog(originalIndex);
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
    );
  }
}
