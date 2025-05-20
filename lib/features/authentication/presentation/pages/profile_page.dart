import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:safepak/core/services/user_singleton.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/configs/theme/app_colors.dart' show AppColors;
import '../../domain/entities/user_entity.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserEntity currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = UserSingleton().user!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
              OctIcons.sign_out,
              color: Colors.white,
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
        // leading: GestureDetector(
        //   child: Container(
        //     margin: const EdgeInsets.all(6.0),
        //     decoration: BoxDecoration(
        //       color: Colors.white.withOpacity(0.3),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child: const Icon(
        //       Icons.arrow_back_ios_new,
        //       color: Colors.white,
        //       size: 14,
        //     ),
        //   ),
        //   onTap: () {
        //     context.go('/home');
        //   },
        // ),
        // actions: [
        //   GestureDetector(
        //     child: Container(
        //       padding: const EdgeInsets.all(16.0),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.white.withOpacity(0.3),
        //       ),
        //       child: const Text(
        //         'EDIT',
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ),
        //     onTap: () {
        //       context.push('/profile/edit', extra: currentUser);
        //     },
        //   ),
        //   const SizedBox(width: 16),
        // ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 70.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 80.0,
                bottom: 16.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.person, 'Name',
                              currentUser.name ?? 'Not Set'),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(Icons.email, 'Email',
                              currentUser.email ?? 'Not Set'),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(Icons.phone, 'Phone Number',
                              currentUser.phoneNumber ?? 'Not Set'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.cake, 'Date of Birth',
                              currentUser.dob ?? 'Not Set'),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(Icons.transgender, 'Gender',
                              currentUser.gender ?? 'Not Set'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.location_city, 'City',
                              currentUser.city ?? 'Not Set'),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(Icons.map, 'Province',
                              currentUser.province ?? 'Not Set'),
                          const SizedBox(height: 12.0),
                          _buildInfoRow(Icons.home, 'Address',
                              currentUser.address ?? 'Not Set'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.lightGrey,
                    child: (currentUser.imageUrl != null &&
                            currentUser.imageUrl!.isNotEmpty)
                        ? ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: currentUser.imageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, progress) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.white,
                                  ),
                                );
                              },
                              placeholder: (context, url) => SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          )
                        : Text(
                            currentUser.name != null &&
                                    currentUser.name!.isNotEmpty
                                ? currentUser.name!
                                    .trim()
                                    .split(' ')
                                    .map((e) => e[0])
                                    .take(2)
                                    .join()
                                    .toUpperCase()
                                : 'N/A',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade600,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
