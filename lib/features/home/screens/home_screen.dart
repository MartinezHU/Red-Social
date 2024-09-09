import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/home/widgets/home_navigation_bar.dart';
import 'package:social_app/features/posts/screens/edit_or_create_post_screen.dart';

import '../../posts/widgets/my_posts_feed.dart';
import '../../posts/widgets/post_home_feed_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0; //Índice de las pestañas

  final List<Widget> _pages = <Widget>[
    const PostsHomeFeed(),
    const MyPersonalFeed(),
    const EditOrCreatePostScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      // ),
      body: _pages[_selectedIndex],
      // Aquí añadimos la barra inferior de navegación
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTabSelected: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const PostFormScreen()),
          // );
        },
        tooltip: 'Crear Post',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
