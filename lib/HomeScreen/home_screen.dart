
import 'package:flutter/material.dart';
import 'package:perfect_couple/TabScreens/favorite_sent_received_screen.dart';
import 'package:perfect_couple/TabScreens/like_sent_received_screen.dart';
import 'package:perfect_couple/TabScreens/swiping_screen.dart';
import 'package:perfect_couple/TabScreens/user_detail_screen.dart';
import 'package:perfect_couple/TabScreens/view_sent_received_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int screenIndex = 0;
  List tabScreensList = [
    const SwipingScreen(),
    const ViewSentReceivedScreen(),
    const FavouriteSentReceivedScreen(),
    const LikeSentReceivedScreen(),
    UserDetailScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber){
          screenIndex = indexNumber;
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.remove_red_eye, size: 30,), label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.star, size: 30,), label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, size: 30,), label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: "",),
        ],
      ),
      body: tabScreensList[screenIndex],
    );
  }
}
