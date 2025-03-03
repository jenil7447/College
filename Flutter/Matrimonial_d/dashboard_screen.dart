import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_D/database/matrimony_database.dart';
import 'package:flutterbasic/Matrimonial_D/screens/about_us.dart';
import 'package:flutterbasic/Matrimonial_D/screens/add_user.dart';
import 'package:flutterbasic/Matrimonial_D/screens/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/string_constants.dart';
import 'login_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> userList = [];
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeList();
    });
  }

  Future<void> initializeList() async {
    userList.addAll(await MatrimonyDatabase().fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.1,
                ),
                children: [
                  DashboardCard(
                    icon: Icons.person_add,
                    label: 'Add User',
                    color: Colors.pink.shade600,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddUser(userList: userList))),
                  ),
                  DashboardCard(
                    icon: Icons.list,
                    label: 'User List',
                    color: Colors.blue.shade600,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserList(userList: userList, isFavourite: false))),
                  ),
                  DashboardCard(
                    icon: Icons.favorite,
                    label: 'Favourites',
                    color: Colors.red.shade600,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserList(userList: userList, isFavourite: true))),
                  ),
                  DashboardCard(
                    icon: Icons.info,
                    label: 'About Us',
                    color: Colors.green.shade600,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  AppBar buildCustomAppBar() {
    return AppBar(
      title: Row(
        children: [
          const Text(
            'SoulConnect',
            style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(width: 4,),
          Icon(Icons.favorite, color: Colors.white, size: 30,),
        ],
      ),
      centerTitle: true,
      elevation: 6,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.purple.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'logout') {
              _showLogoutDialog(context);
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Icon(Icons.logout, color: Colors.purple.shade900),
            ),
          ),
        ),
      ],
    );
  }
}



void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text('Do you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Clear login state and navigate to login screen
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool(IS_LOGIN, false);

              Navigator.of(context).pop(); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}


class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
