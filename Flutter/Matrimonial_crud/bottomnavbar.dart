import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_2/home_screen.dart';
import 'package:flutterbasic/Matrimonial_2/favorite_users_screen_state.dart';
import 'package:flutterbasic/Matrimonial_2/user_list_screen.dart';
import 'package:flutterbasic/Matrimonial_2/aboutuspage.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    setState(() {
      selectedIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      Widget nextPage;
      switch (index) {
        case 0:
          nextPage = HomeScreen();
          break;
        case 1:
          nextPage = FavoriteUserScreen();
          break;
        case 2:
          nextPage = UserListScreen();
          break;
        case 3:
          nextPage = AboutUsPage();
          break;
        default:
          return;
      }

      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => nextPage,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 100),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double underlineWidth = screenWidth / 4;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => _onItemTapped(context, index),
          selectedItemColor: Colors.pinkAccent,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Users',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About Us',
            ),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          left: selectedIndex * underlineWidth,
          bottom: 0,
          child: Container(
            width: underlineWidth,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}