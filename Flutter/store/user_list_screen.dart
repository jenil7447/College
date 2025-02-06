import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/add_user_screen.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';
import 'package:flutter/cupertino.dart';

class UserListScreen extends StatefulWidget {
  final User userInstance;

  UserListScreen({Key? key, required this.userInstance}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    userList = widget.userInstance.getUser_details() ?? [];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B3A4B), Color(0xFF2E5568), Color(0xFF3F7185)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
            title: const Text(
              'UserList',
              style: TextStyle(
                fontFamily: 'Montserrat', // Elegant font
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    userList = widget.userInstance
                        .searchDetail(searchData: value) ??
                        [];
                  });
                },
              ),
            ),
            Expanded(
              child: userList.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_off,
                    size: 100,
                    color: Colors.white54,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No users found',
                    style: TextStyle(
                        fontSize: 18, color: Colors.white70),
                  ),
                ],
              )
                  : ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return Card(
                    color: Colors.white24,
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.lightBlueAccent,
                            child: Text(
                              user['fullName'] != null &&
                                  user['fullName'].isNotEmpty
                                  ? user['fullName'][0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['fullName'] ?? 'No Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Email: ${user['email'] ?? 'N/A'}',
                                  style: TextStyle(fontSize: 14,color: Colors.white),
                                ),
                                Text(
                                  'Mobile: ${user['mobile'] ?? 'N/A'}',
                                  style: TextStyle(fontSize: 14,color: Colors.white),
                                ),
                                Text(
                                  'DOB: ${user['dob'] ?? 'N/A'}',
                                  style: TextStyle(fontSize: 14,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  widget.userInstance.getFavoriteUsers()?.any((element) => element['email'] == user['email']) == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: widget.userInstance.getFavoriteUsers()?.any((element) => element['email'] == user['email']) == true
                                      ? Colors.pink
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (widget.userInstance.getFavoriteUsers()?.any((element) => element['email'] == user['email']) == true) {
                                      widget.userInstance.removeFromFavorites(user);
                                    } else {
                                      widget.userInstance.addToFavorites(user);
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddEditUserScreen(
                                        userInstance: widget.userInstance,
                                        index: index,
                                        user: user,
                                      ),
                                    ),
                                  );

                                  if (result == true) {
                                    setState(() {
                                      print("🔄 Refreshing user list...");
                                      userList = widget.userInstance.getUser_details() ?? [];
                                    });
                                  }
                                },

                              ),

                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CupertinoAlertDialog(
                                        title: Text('DELETE'),
                                        content: Text(
                                            'Are you sure want to delete?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.userInstance
                                                    .delete_user(
                                                    index);
                                                userList = widget
                                                    .userInstance
                                                    .getUser_details() ??
                                                    [];
                                              });
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(
                                                  context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'User deleted successfully!'),
                                                ),
                                              );
                                            },
                                            child: Text('Yes'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
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
      ),
    );
  }
}