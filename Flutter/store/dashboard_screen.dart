import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial/aboutus_screen.dart';
import 'package:flutterbasic/Matrimonial/add_user_screen.dart';
import 'package:flutterbasic/Matrimonial/favorites_screen.dart';
import 'package:flutterbasic/Matrimonial/user_list_screen.dart';
import 'package:flutterbasic/Matrimonial/crud_file.dart';

class DashboardScreen extends StatefulWidget {
  final User userInstance;

  DashboardScreen({Key? key, required this.userInstance}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      DashboardContent(userInstance: widget.userInstance),
      UserListScreen(userInstance: widget.userInstance),
      FavoritesScreen(userInstance: widget.userInstance),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  final User userInstance;

  DashboardContent({Key? key, required this.userInstance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "                Matrimonial App",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),

          ),
        ),
        Expanded(
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
                  colors: [Color(0xFF8E44AD), Color(0xFF9B59B6)],
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
                  colors: [Color(0xFF2980B9), Color(0xFF6DD5FA)],
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
                  colors: [Color(0xFFF7971E), Color(0xFFFFD200)],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen(
                          userInstance: userInstance,
                        ),
                      ),
                    );
                  },
                ),
                customDashboardButton(
                  icon: Icons.info,
                  label: "About Us",
                  colors: [Color(0xFF34e89e), Color(0xFF0f3443)],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget customDashboardButton({
  required IconData icon,
  required String label,
  required List<Color> colors,
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