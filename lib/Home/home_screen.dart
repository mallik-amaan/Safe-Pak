import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safepak/Home/widgets/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/authentication/presentation/pages/login_page.dart';
import '../FIR Registration/track_fir_screen.dart';
import '../Notifications/announcement_screen.dart';
import '../Notifications/update_screen.dart';
import '../Profile/profile_screen.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0;

  // List of screens for each navigation item
  final List<Widget> _screens = [
    const HomePage(), // Home page with GridView
    ProfileScreen(),
    AnnouncementScreen(),
    TrackFirScreen(),
    UpdateScreen(),
  ];

  // List of navigation items
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home_filled, 'label': 'Home', 'color': Colors.deepPurple},
    {'icon': Icons.person, 'label': 'Profile', 'color': Colors.blue},
    {'icon': Icons.abc, 'label': 'Alerts', 'color': Colors.orange},
    {'icon': Icons.track_changes, 'label': 'Track FIR', 'color': Colors.indigo},
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection("users").doc(user.uid).get();
      // if (userDoc.exists) {
      //   setState(() {
      //     _username = userDoc["name"] ?? "No Name";
      //     _email = user.email ?? "No Email";
      //   });
      // }
    }
  }

  void _onItemTapped(int index) {
    if (index == _navItems.length) {
      // Handle logout
      _logout();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // User info header

          // Main content
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        navItems: _navItems,
      ),
    );
  }
}
