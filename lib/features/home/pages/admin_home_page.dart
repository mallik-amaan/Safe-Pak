import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/core/services/user_singleton.dart';
import 'package:safepak/features/home/widgets/admin_home_cards.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Icon(
              OctIcons.sign_out,
              color: Colors.black,
              size: 20,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Sign Out'),
                  content: const Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () {
                        UserSingleton().clearUser();
                        Navigator.of(context).pop();
                        context.go('/login');
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
        children: adminHomeCards(context),
      ),
    );
  }
}