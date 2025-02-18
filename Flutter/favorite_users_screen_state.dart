import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/database.dart';

class FavoriteUserScreen extends StatefulWidget {
  @override
  _FavoriteUserScreenState createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _searchQuery = '';
  final DBHelper dbHelper = DBHelper.getInstance; // Updated to use the singleton instance
  List<Map<String, dynamic>> favoriteUsers = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _loadFavoriteUsers();
  }

  Future<void> _loadFavoriteUsers() async {
    final users = await dbHelper.searchUsers(_searchQuery);
    setState(() {
      favoriteUsers = users.where((user) => user['isFavorite'] == 1).toList();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _refreshScreen() {
    _loadFavoriteUsers();
    _animationController.forward(from: 0);
  }

  void _showDeleteDialog(int id) {
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
            onPressed: () async {
              await dbHelper.deleteUser(id);
              _refreshScreen();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User deleted successfully'),
                  backgroundColor: Colors.deepPurple,
                ),
              );
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editUser(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProfileScreen(userData: user, userId: user['id']),
      ),
    ).then((_) => _refreshScreen());
  }

  @override
  Widget build(BuildContext context) {
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
                    _loadFavoriteUsers();
                  });
                },
              ),
            ),
            Expanded(
              child: favoriteUsers.isEmpty
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
                itemCount: favoriteUsers.length,
                itemBuilder: (context, index) {
                  final user = favoriteUsers[index];
                  List<dynamic> hobbies = user['hobbies'] is String
                      ? []
                      : user['hobbies'] as List<dynamic>;

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
                                  child: Text(
                                    user["firstName"][0].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user["firstName"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.deepPurple.shade700,
                                        ),
                                      ),
                                      Text(
                                        '${user["age"]} years • ${user["gender"] == 1 ? "Male" : "Female"}',
                                        style: TextStyle(
                                          color: Colors.deepPurple.shade400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await dbHelper.updateUserFavoriteStatus(
                                        user['id'],
                                        0
                                    );
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
                                      _editUser(user);
                                    } else if (value == "delete") {
                                      _showDeleteDialog(user['id']);
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
                            Divider(color: Colors.deepPurple.shade100),
                            SizedBox(height: 8),
                            _buildInfoRow(Icons.location_on, user["city"], Colors.orange),
                            SizedBox(height: 5),
                            _buildInfoRow(Icons.phone, user["mobile"], Colors.green),
                            SizedBox(height: 5),
                            _buildInfoRow(Icons.email, user["email"], Colors.red),
                            if (hobbies.isNotEmpty) ...[
                              SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: hobbies.map((hobby) => Chip(
                                  label: Text(
                                    hobby,
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 12,
                                    ),
                                  ),
                                  backgroundColor: Colors.deepPurple.shade50,
                                )).toList(),
                              ),
                            ],
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
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.deepPurple.shade700,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}