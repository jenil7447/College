import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/add_user_screen.dart';
import 'package:flutterbasic/Matrimonial/user_list_screen.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';

class DashboardScreen extends StatelessWidget {
  final User userInstance;

  DashboardScreen({Key? key, required this.userInstance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend background under the AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // Remove shadow
        title: const Text(
          'Matrimony App',
          style: TextStyle(
            fontFamily: 'Montserrat', // Elegant font
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], // Gradient background
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              customDashboardButton(
                icon: Icons.person_add,
                label: "Add User",
                colors: [Color(0xFF8E44AD), Color(0xFF9B59B6)], // Purple gradient
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditUserScreen(
                        userInstance: userInstance,
                      ),
                    ),
                  );
                },
              ),
              customDashboardButton(
                icon: Icons.list,
                label: "User List",
                colors: [Color(0xFF2980B9), Color(0xFF6DD5FA)], // Blue gradient
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(
                        userInstance: userInstance,
                      ),
                    ),
                  );
                },
              ),
              customDashboardButton(
                icon: Icons.favorite,
                label: "Favorites",
                colors: [Color(0xFFF7971E), Color(0xFFFFD200)], // Orange gradient
                onTap: () {
                  // Navigate to Favorites Screen
                },
              ),
              customDashboardButton(
                icon: Icons.info,
                label: "About Us",
                colors: [Color(0xFF34e89e), Color(0xFF0f3443)], // Green gradient
                onTap: () {
                  // Navigate to About Us Screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDashboardButton({
    required IconData icon,
    required String label,
    required List<Color> colors, // Pass gradient colors
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(-4, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.white,
            ),
            const SizedBox(height: 12.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
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
