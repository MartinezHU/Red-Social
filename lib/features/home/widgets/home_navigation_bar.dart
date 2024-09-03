import 'package:flutter/material.dart';

typedef OnTabSelectedCallback = void Function(int index);

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final OnTabSelectedCallback onTabSelected;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: currentIndex,
      onTap: onTabSelected,
    );
  }
}
