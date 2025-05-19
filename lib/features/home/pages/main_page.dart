import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:safepak/FIR%20Registration/track_fir_screen.dart';
import 'package:safepak/Profile/profile_screen.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import '../../authentication/presentation/pages/profile_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  // List of screens for each navigation item
  final List<Widget> _screens = [
    const HomePage(),
    TrackFirScreen(),
    ProfilePage(),
  ];

  // List of navigation items
  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': Icons.home_filled,
      'label': 'Home',
      'color': AppColors.primaryColor,
    },
    {
      'icon': Icons.track_changes,
      'label': 'Track FIR',
      'color': AppColors.primaryColor,
    },
    {
      'icon': Icons.person,
      'label': 'Profile',
      'color': AppColors.primaryColor,
    },
  ];

  List<PersistentBottomNavBarItem> _buildNavBarItems() {
    return _navItems.map((item) {
      return PersistentBottomNavBarItem(
        icon: Icon(item['icon']),
        title: item['label'],
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.secondaryColor.withOpacity(0.6),
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        items: _buildNavBarItems(),
        navBarStyle: NavBarStyle.style9,
        backgroundColor: Colors.white,
        decoration: NavBarDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        navBarHeight: 70,
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}