import 'package:go_router/go_router.dart';
import 'package:safepak/Home/home_screen.dart';
import 'package:safepak/features/authentication/presentation/pages/create_account_page_1.dart';
import 'package:safepak/features/authentication/presentation/pages/create_account_page_2.dart';
import 'package:safepak/features/authentication/presentation/pages/success_page.dart';

import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/authentication/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(
          path: 'register',
          builder: (context, state) => RegisterPage(),
        ),
      ],
    ),
     GoRoute(
      path: '/home',
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      path: '/create_account_page_1',
      builder: (context, state) => CreateAccountPage1(),
      routes: [
        GoRoute(
          path: 'create_account_page_2',
          builder: (context, state) => CreateAccountPage2(),
        ),
      ],
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) => SuccessPage(),
    ),
  ],
);
