import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/favorite_users_screen_state.dart';
import 'package:flutterbasic/Matrimonial_2/user_list_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink.shade400,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 40),
                Icon(Icons.favorite, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Matrimony",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Welcome Matrimony",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Find your perfect match with us",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.symmetric(horizontal: 20),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                MenuCard(icon: Icons.person_add, title: "Add Profile", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddProfileScreen()))),
                MenuCard(icon: Icons.people, title: "Browse Profiles", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserListScreen()))),
                MenuCard(icon: Icons.favorite, title: "Favorites", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteUserScreen()))),
                MenuCard(icon: Icons.info, title: "About Us", onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.pinkAccent),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"), backgroundColor: Colors.pink.shade400),
      body: Center(child: Text("About Us Page")),
    );
  }
}
