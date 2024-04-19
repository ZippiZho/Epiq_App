import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomBarMaterial extends StatelessWidget {

  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBarMaterial({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color colorIcon= Color(0xFFFFFFFF);
    const Color colorSelect= Color(0xFF4CAB5E);
    const Color colorBackground= Color(0xFF141212);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BottomNavigationBar(
          unselectedItemColor: colorIcon,
          selectedItemColor: colorSelect,
          onTap: onTap,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorBackground,
          iconSize: 24,
          showUnselectedLabels: false,
          items: [
            _bottomNavigationBarItem(
              icon: Icons.home_rounded,
              label: 'Home',
            ),
            _bottomNavigationBarItem(
              icon: CupertinoIcons.bookmark,
              label: 'Book',
            ),
            _bottomNavigationBarItem(
              icon: Icons.history,
              label: 'Explore',
            ),
            _bottomNavigationBarItem(
              icon: CupertinoIcons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
  BottomNavigationBarItem _bottomNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
