import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';
import 'list_animations.dart';
import 'package:flutterbasic/Matrimonial_2/user_detail_screen.dart';
class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> with SingleTickerProviderStateMixin {
  String searchQuery = "";
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;

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

  static List<Map<String, dynamic>> searchDetail(String searchData) {
    searchData = searchData.toLowerCase();
    return UserCrud.userDetails.where((user) {
      return user["fullName"].toLowerCase().contains(searchData) ||
          user["email"].toLowerCase().contains(searchData) ||
          user["mobile"].toLowerCase().contains(searchData) ||
          user["dob"].toLowerCase().contains(searchData) ||
          user["city"].toLowerCase().contains(searchData) ||
          user["gender"].toLowerCase().contains(searchData) ||
          (user["hobbies"] != null && user["hobbies"].any((hobby) =>
              hobby.toString().toLowerCase().contains(searchData)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = searchQuery.isEmpty
        ? UserCrud.userDetails
        : searchDetail(searchQuery);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "All Users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
        elevation: 0,
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
            SizedBox(height: 100), // Space for AppBar
            AnimatedSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Expanded(
              child: filteredUsers.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.deepPurple.shade200,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "No users found",
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
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return AnimatedListItem(
                    index: index,
                    isEven: index.isEven,
                      child: InkWell(  // Add this
                      onTap: () {    // Add this
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(userData: user),
                      ),
                    );
                  },
                  child: Card(
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
                                  Hero(
                                    tag: 'avatar_${user["fullName"]}',
                                    child: CircleAvatar(
                                      backgroundColor: Colors.deepPurple[100],
                                      child: Icon(Icons.person, color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          user["fullName"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.deepPurple.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedFavoriteButton(
                                    isFavorite: user["isFavorite"] ?? false,
                                    onPressed: () {
                                      UserCrud.toggleFavorite(index);
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
                                        _editUser(index);
                                      } else if (value == "delete") {
                                        _showDeleteDialog(index);
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        value: "edit",
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit, size: 20, color: Colors.deepPurple),
                                            SizedBox(width: 8),
                                            Text("Edit", style: TextStyle(color: Colors.deepPurple)),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: "delete",
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, size: 20, color: Colors.red),
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
                              _buildInfoRow(Icons.location_on, user["city"], Colors.deepPurple),
                              SizedBox(height: 8),
                              _buildInfoRow(Icons.phone, user["mobile"], Colors.green),
                              SizedBox(height: 8),
                              _buildInfoRow(Icons.email, user["email"], Colors.red),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate()
                      .fadeIn(duration: Duration(milliseconds: 500))
                      .slideY(begin: 0.2, end: 0));
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