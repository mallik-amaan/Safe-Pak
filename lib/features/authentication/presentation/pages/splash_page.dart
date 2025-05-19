import 'package:go_router/go_router.dart';
import 'package:safepak/core/configs/const/asset_const.dart';
import 'package:flutter/material.dart';
import 'package:safepak/core/configs/services/user_singleton.dart';
import 'package:safepak/features/authentication/domain/entities/user_entity.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the login page after the splash screen
      // ignore: use_build_context_synchronously
      UserEntity? user = UserSingleton().user;
      if(user==null){
      context.go('/login');

      }else{
        context.go('/home');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AssetConst.logoWithText,
          width: 200,
        ),
      ),
    );
  }
}