import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_D/constants/string_constants.dart';
import 'package:flutterbasic/Matrimonial_D/database/matrimony_database.dart';
import 'package:flutterbasic/Matrimonial_D/screens/add_user.dart';
import 'package:flutterbasic/Matrimonial_D/screens/user_details.dart';

class UserList extends StatefulWidget {
  final List<Map<String, dynamic>> userList;
  bool isFavourite;
  UserList({super.key, required this.userList, required this.isFavourite});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final searchController = TextEditingController();
  String searchQuery = '';
  String selectedSort = 'Sort by';

  void sortUsers(String criteria) {
    setState(() {
      selectedSort = criteria;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredUsers = widget.userList.where((user) {
      return (widget.isFavourite ? user[FAVOURITE] == 1 : true) &&
          (user[NAME].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              user[CITY].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              user[EMAIL].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
              user[PHONE].toString().toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();

    if(selectedSort != 'Sort by') {
      filteredUsers.sort((a, b) {
        switch (selectedSort) {
          case 'Name A-Z':
            return a[NAME].compareTo(b[NAME]);
          case 'Name Z-A':
            return b[NAME].compareTo(a[NAME]);
          case 'Age Ascending':
            return a[AGE].compareTo(b[AGE]);
          case 'Age Descending':
            return b[AGE].compareTo(a[AGE]);
          case 'Email A-Z':
            return a[EMAIL].compareTo(b[EMAIL]);
          case 'Email Z-A':
            return b[EMAIL].compareTo(a[EMAIL]);
          default:
            return 0;
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isFavourite ? 'Favourite Users' : 'User List'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900, Colors.purple.shade700], // Adjust colors to match the image
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.deepPurple, width: 1.5),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedSort,
                icon: Icon(Icons.sort, color: Colors.deepPurple),
                items: [
                  'Sort by',
                  'Name A-Z',
                  'Name Z-A',
                  'Age Ascending',
                  'Age Descending',
                  'Email A-Z',
                  'Email Z-A',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 16)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) sortUsers(newValue);
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: 'Search users...',
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: searchUser,
            ),
            SizedBox(height: 16),
            filteredUsers.isEmpty
                ? Expanded(
                              child: Center(
                                              child: Text(
                                                'No Users Found',
                                                style: TextStyle(fontSize: 20, color: Colors.grey),
                                              ),
                              ),
                            )
                : Expanded(
                              child: ListView.builder(
                                                  itemCount: filteredUsers.length,
                                                  itemBuilder: (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        int idx = widget.userList.indexOf(filteredUsers[index]);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                              UserDetails(userDetails: filteredUsers[index], userList: widget.userList, index: idx,),
                                                          ),
                                                        );
                                                      },
                                                      child: Card(
                                                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        elevation: 5,
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding: EdgeInsets.all(12),
                                                          child: Row(
                                                            children: [
                                                              // Circular Name Icon
                                                              CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.deepPurple.withOpacity(0.2),
                              child: Icon(Icons.person, size: 30, color: Colors.deepPurple),
                                                              ),
                                                              SizedBox(width: 16),

                                                              // User Information Column
                                                              Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${filteredUsers[index][NAME]} (Age: ${filteredUsers[index][AGE]})',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),

                                  // Location
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 18, color: Colors.blueGrey),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          '${filteredUsers[index][CITY]}',
                                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),

                                  // Phone
                                  Row(
                                    children: [
                                      Icon(Icons.phone, size: 18, color: Colors.green),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          '${filteredUsers[index][PHONE]}',
                                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),

                                  // Email
                                  Row(
                                    children: [
                                      Icon(Icons.email, size: 18, color: Colors.orange),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          '${filteredUsers[index][EMAIL]}',
                                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                                              ),

                                                              // Action Buttons
                                                              Column(
                              children: [
                                // Favorite Button (Heart Icon)
                                IconButton(
                                  onPressed: () async {
                                    int idx = widget.userList.indexOf(filteredUsers[index]);
                                    int? id = await MatrimonyDatabase().getId(widget.userList[idx][EMAIL]);
                                    if(widget.userList[idx][FAVOURITE] == 1) {
                                      MatrimonyDatabase().setFavourite(id, false);
                                      widget.userList[idx][FAVOURITE] = 0;
                                    }
                                    else {
                                      MatrimonyDatabase().setFavourite(id, true);
                                      widget.userList[idx][FAVOURITE] = 1;
                                    }
                                    setState(() {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(widget.userList[idx][FAVOURITE] == 1
                                              ? "User Added to Favourites"
                                              : "User Removed from Favourites"),
                                        ),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: filteredUsers[index][FAVOURITE] == 1 ? Colors.red : Colors.grey,
                                    size: 28,
                                  ),
                                ),

                                // Edit Button
                                IconButton(
                                  onPressed: () {
                                    int idx = widget.userList.indexOf(filteredUsers[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddUser(userList: widget.userList, index: idx),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue, size: 28),
                                ),

                                // Delete Button
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Delete User'),
                                          content: Text('Are you sure you want to delete this user?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                int idx = widget.userList.indexOf(filteredUsers[index]);
                                                int? id = await MatrimonyDatabase().getId(widget.userList[idx][EMAIL]);
                                                MatrimonyDatabase().deleteUser(id);
                                                widget.userList.removeAt(idx);
                                                setState(() {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("User Deleted")),
                                                  );
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Yes', style: TextStyle(color: Colors.red)),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text('No', style: TextStyle(color: Colors.black)),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red, size: 28),
                                ),
                              ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                              ),
                            ),
          ],
        ),
      ),
    );
  }

  void searchUser(String query) {
    setState(() {
      searchQuery = query;
    });
  }
}