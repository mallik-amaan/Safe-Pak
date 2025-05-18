import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common/widgets/button_widget.dart';
import '../../../../core/configs/const/asset_const.dart';
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AssetConst.checkMark, height: 300, repeat: false),
            const Text(
              'Successfully Signed up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ButtonWidget(
              content: const Text('Continue To Home'),
              onPressed: () {
                context.go('/home', extra: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
