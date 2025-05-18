import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/authentication/presentation/pages/login_page.dart';
import '../FIR Registration/crime_reporting_screen.dart';
import '../FIR Registration/track_fir_screen.dart';
import '../Notifications/announcement_screen.dart';
import '../Notifications/update_screen.dart';
import '../Profile/profile_screen.dart';

Widget buildDrawer(BuildContext context,FirebaseAuth _auth)  {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          accountName: Text(
            "_username",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          accountEmail: Text("_email", style: TextStyle(fontSize: 16)),
        ),
        _buildDrawerItem(Icons.report, "Report FIR", Colors.deepPurple,
                () => _navigateTo(CrimeReportingScreen(),context)),
        _buildDrawerItem(Icons.person, "Profile", Colors.blue,
                () => _navigateTo(ProfileScreen(),context)),
        _buildDrawerItem(Icons.announcement, "Announcements", Colors.orange,
                () => _navigateTo(AnnouncementScreen(),context)),
        _buildDrawerItem(Icons.track_changes, "Track FIR", Theme.of(context).primaryColor,
                () => _navigateTo(TrackFirScreen(),context)),
        _buildDrawerItem(Icons.update, "Update Information", Colors.teal,
                () => _navigateTo(UpdateScreen(),context)),
        Divider(),
        _buildDrawerItem(Icons.logout, "Logout", Colors.redAccent, () => _logout(context,_auth)),
      ],
    ),
  );
}

Widget _buildDrawerItem(
    IconData icon, String title, Color color, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: color, size: 26),
    title: Text(title, style: TextStyle(fontSize: 16)),
    onTap: onTap,
  );
}

void _navigateTo(Widget screen,BuildContext context) {
  Navigator.pop(context);
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

Future<void> _logout(BuildContext context,FirebaseAuth _auth) async {
  await _auth.signOut();
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}
