import 'package:flutter/material.dart';
import 'package:flutter_clean/app/features/posts/presentation/pages/post_page.dart';
import 'package:flutter_clean/app/features/posts/presentation/pages/profile_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int index = 0;

  final List<Widget> pages =[
    PostPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home)),
        BottomNavigationBarItem(icon: Icon(Icons.person)),
      ]),

    );
  }
}
