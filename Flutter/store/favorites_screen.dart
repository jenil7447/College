import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/add_user_screen.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';
import 'package:flutter/cupertino.dart';

class FavoritesScreen extends StatefulWidget {
  final User userInstance;

  FavoritesScreen({Key? key, required this.userInstance}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    userList = widget.userInstance.getFavoriteUsers() ?? [];
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
            elevation: 0,
            title: const Text(
              'Favorites',
              style: TextStyle(
                fontFamily: 'Montserrat',
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
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Colors.white24,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    userList = widget.userInstance.getFavoriteUsers()?.where((user) {
                      return user['fullName'].toString().toLowerCase().contains(value.toLowerCase());
                    }).toList() ?? [];
                  });
                },
              ),
            ),
            // User List
            Expanded(
              child: userList.isEmpty
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.person_off, size: 100, color: Colors.white54),
                  SizedBox(height: 20),
                  Text(
                    'No users found',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
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
                          // Avatar
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.lightBlueAccent,
                            child: Text(
                              user['fullName'] != null && user['fullName'].isNotEmpty
                                  ? user['fullName'][0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // User Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['fullName'] ?? 'No Name',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Email: ${user['email'] ?? 'N/A'}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  'Mobile: ${user['mobile'] ?? 'N/A'}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                Text(
                                  'DOB: ${user['dob'] ?? 'N/A'}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          // Action Buttons
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite, color: Colors.pink),
                                onPressed: () {
                                  setState(() {
                                    widget.userInstance.removeFromFavorites(user);
                                    userList = widget.userInstance.getFavoriteUsers() ?? [];
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('User removed from favorites'),
                                    ),
                                  );
                                },
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.edit, color: Colors.blue),
                              //   onPressed: () async {
                              //     final result = await Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => AddEditUserScreen(
                              //           userInstance: widget.userInstance,
                              //           index: index,
                              //           user: user,
                              //         ),
                              //       ),
                              //     );
                              //
                              //     if (result == true) {
                              //       setState(() {
                              //         print("🔄 Refreshing user list...");
                              //         userList = widget.userInstance.getUser_details() ?? [];
                              //       });
                              //     }
                              //   },
                              //
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.delete, color: Colors.red),
                              //   onPressed: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return CupertinoAlertDialog(
                              //           title: const Text('DELETE'),
                              //           content: const Text(
                              //               'Are you sure you want to delete this user?'),
                              //           actions: [
                              //             TextButton(
                              //               onPressed: () {
                              //                 setState(() {
                              //                   widget.userInstance.delete_user(index);
                              //                   userList = widget.userInstance.getUser_details() ?? [];
                              //                 });
                              //                 Navigator.pop(context);
                              //                 ScaffoldMessenger.of(context).showSnackBar(
                              //                   const SnackBar(
                              //                     content:
                              //                     Text('User deleted successfully!'),
                              //                   ),
                              //                 );
                              //               },
                              //               child: const Text('Yes'),
                              //             ),
                              //             TextButton(
                              //               onPressed: () {
                              //                 Navigator.pop(context);
                              //               },
                              //               child: const Text('No'),
                              //             ),
                              //           ],
                              //         );
                              //       },
                              //     );
                              //   },
                              // ),
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