import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_2/aboutuspage.dart';
import 'package:flutterbasic/Matrimonial_2/add_profile_screen.dart';
import 'package:flutterbasic/Matrimonial_2/favorite_users_screen_state.dart';
import 'package:flutterbasic/Matrimonial_2/user_list_screen.dart';
import 'package:flutterbasic/Matrimonial_2/crud.dart';

// Custom Color Palette
class AppColors {
  static const Color primary = Color(0xFF8E2DE2);
  static const Color secondary = Color(0xFF4A00E0);
  static const Color accent1 = Color(0xFFF6B5CC);
  static const Color accent2 = Color(0xFFFFB4B4);
  static const Color background = Color(0xFFF8F9FF);
  static const Color cardBg = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  // Menu Item Colors
  static const Color menuItem1 = Color(0xFF6C5CE7);
  static const Color menuItem2 = Color(0xFFFF7675);
  static const Color menuItem3 = Color(0xFF26de81);
  static const Color menuItem4 = Color(0xFFf368e0);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5)),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Decorative Background Elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent1.withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent2.withOpacity(0.15),
              ),
            ),
          ),
          Column(
            children: [
              // Enhanced Header with Gradient
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Hero(
                          tag: 'app_icon',
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Matrimony",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Find your perfect match",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Enhanced Grid Menu
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1,
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return MenuCard(menuItems[index], index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Updated MenuItem class with new colors
List<MenuItem> menuItems = [
  MenuItem(
    icon: Icons.person_add,
    title: "Add Profile",
    page: AddProfileScreen(),
    color: AppColors.menuItem1,
  ),
  MenuItem(
    icon: Icons.people,
    title: "Browse Profiles",
    page: UserListScreen(),
    color: AppColors.menuItem2,
  ),
  MenuItem(
    icon: Icons.favorite,
    title: "Favorites",
    page: FavoriteUserScreen(),
    color: AppColors.menuItem3,
  ),
  MenuItem(
    icon: Icons.info,
    title: "About Us",
    page: AboutUsPage(),
    color: AppColors.menuItem4,
  ),
];

class MenuItem {
  final IconData icon;
  final String title;
  final Widget page;
  final Color color;

  MenuItem({
    required this.icon,
    required this.title,
    required this.page,
    required this.color,
  });
}

class MenuCard extends StatefulWidget {
  final MenuItem item;
  final int index;

  MenuCard(this.item, this.index);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              _controller.forward();
              setState(() => _isPressed = true);
            },
            onTapUp: (_) {
              _controller.reverse();
              setState(() => _isPressed = false);
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                  widget.item.page,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: Duration(milliseconds: 500),
                ),
              );
            },
            onTapCancel: () {
              _controller.reverse();
              setState(() => _isPressed = false);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: widget.item.color.withOpacity(0.2),
                    blurRadius: _isPressed ? 15 : 10,
                    spreadRadius: _isPressed ? 2 : 5,
                    offset: _isPressed ? Offset(2, 2) : Offset(3, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: widget.item.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.item.icon,
                      size: 35,
                      color: widget.item.color,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.item.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "About Us Page",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}