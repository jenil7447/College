import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';

class FavoriteUserScreen extends StatefulWidget {
  @override
  _FavoriteUserScreenState createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _refreshScreen() {
    setState(() {
      _animationController.forward(from: 0);
    });
  }

  List<Map<String, dynamic>> _filterFavoriteUsers(List<Map<String, dynamic>> favoriteUsers) {
    if (_searchQuery.isEmpty) return favoriteUsers;

    return favoriteUsers.where((user) {
      final searchLower = _searchQuery.toLowerCase();
      return user["fullName"].toLowerCase().contains(searchLower) ||
          user["email"].toLowerCase().contains(searchLower) ||
          user["mobile"].toLowerCase().contains(searchLower) ||
          user["city"].toLowerCase().contains(searchLower);
    }).toList();
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.deepPurple.shade200, width: 2),
        ),
        backgroundColor: Colors.purple.shade50,
        title: Text(
          "Delete User",
          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to delete this user?",
          style: TextStyle(color: Colors.deepPurple.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.deepPurple)),
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
    List<Map<String, dynamic>> filteredUsers = _filterFavoriteUsers(favoriteUsers);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Favorite Users",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black45,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.deepPurple.withOpacity(0.7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade50,
              Colors.white
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 100, 16, 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search favorite users...',
                  prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.deepPurple.shade200,
                    ),
                    SizedBox(height: 16),
                    Text(
                      _searchQuery.isEmpty
                          ? "No favorite users available"
                          : "No users found matching '$_searchQuery'",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  int originalIndex = UserCrud.userDetails.indexOf(user);
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: Colors.deepPurple.shade100,
                          width: 1
                      ),
                    ),
                    elevation: 5,
                    shadowColor: Colors.deepPurple.shade200,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.deepPurple.shade50
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.deepPurple[100],
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user["fullName"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.deepPurple.shade700,
                                        ),
                                      ),
                                      Divider(color: Colors.deepPurple.shade100),
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
                                  color: Colors.deepPurple.shade50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  onSelected: (value) {
                                    if (value == "edit") {
                                      _editUser(originalIndex);
                                    } else if (value == "delete") {
                                      _showDeleteDialog(originalIndex);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: "edit",
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit, color: Colors.deepPurple),
                                          SizedBox(width: 8),
                                          Text("Edit", style: TextStyle(color: Colors.deepPurple)),
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      value: "delete",
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text("Delete", style: TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: Icon(Icons.more_vert, color: Colors.deepPurple),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            _buildInfoRow(Icons.location_on, user["city"], Colors.orange),
                            SizedBox(height: 5),
                            _buildInfoRow(Icons.phone, user["mobile"], Colors.green),
                            SizedBox(height: 5),
                            _buildInfoRow(Icons.email, user["email"], Colors.red),
                          ],
                        ),
                      ),
                    ),
                  ).animate()
                      .fadeIn(duration: Duration(milliseconds: 500))
                      .slideY(begin: 0.2, end: 0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.deepPurple.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}