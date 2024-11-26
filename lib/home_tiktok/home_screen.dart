import 'package:flutter/material.dart';
import 'package:spotify_clone/home_tiktok/profile/profile_screen.dart';
import 'package:spotify_clone/home_tiktok/search/search_screen.dart';
import 'package:spotify_clone/home_tiktok/upload_video/upload_custom-icon.dart';
import 'package:spotify_clone/home_tiktok/upload_video/upload_video_screen.dart';
import 'for_you/for_you_video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;
  List<Widget> screenList = [
    ForYouVideoScreen(),
    UploadVideoScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            screenIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: UploadCustomIcon(),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Me",
          ),



        ],
      ),
      body: screenList[screenIndex],
    );
  }
}
