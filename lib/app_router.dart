import 'package:go_router/go_router.dart';
import 'package:safepak/features/authentication/presentation/pages/create_account_page_1.dart';
import 'package:safepak/features/authentication/presentation/pages/create_account_page_2.dart';
import 'package:safepak/features/authentication/presentation/pages/success_page.dart';
import 'package:safepak/features/criminal_alert/presentation/screens/admin/add_criminal_alert.dart';
import 'package:safepak/features/criminal_alert/presentation/screens/admin/admin_criminal_alerts.dart';
import 'package:safepak/features/chatbot/presentation/screens/chat_screen.dart';

import 'package:safepak/features/criminal_alert/presentation/screens/criminal_alert.dart';
import 'package:safepak/features/emeregency_sos/presentation/screens/admin/admin_emergency_page.dart';
import 'package:safepak/features/emeregency_sos/presentation/screens/emergency_page.dart';
import 'package:safepak/features/emeregency_sos/presentation/screens/emergency_details.dart';
import 'package:safepak/features/fir/presentation/pages/admin/admin_fir_details_page.dart';
import 'package:safepak/features/fir/presentation/pages/admin/admin_fir_page.dart';
import 'package:safepak/features/home/pages/admin_home_page.dart';
import 'package:safepak/features/home/pages/main_page.dart';

import 'features/authentication/presentation/pages/login_page.dart';
import 'features/authentication/presentation/pages/register_page.dart';
import 'features/authentication/presentation/pages/splash_page.dart';
import 'features/fir/presentation/pages/fir_details_page.dart';
import 'features/fir/presentation/pages/fir_registration_page.dart';

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
    GoRoute(
      path: '/fir_details',
      builder: (context, state) => FirDetailsPage(),
    ),
    GoRoute(
        path: '/emergency',
        builder: (context, state) => EmergencyPage(),
        routes: [
          GoRoute(
            path: '/emergency_details',
            builder: (context, state) => EmergencyDetailsScreen(),
          ),
        ]),
    GoRoute(
      path: '/fir_registration',
      builder: (context, state) => FirRegistrationPage(),
    ),
    GoRoute(
      path: '/criminal_alert',
      builder: (context, state) => CriminalAlertPage(),
      routes: [
        GoRoute(
          path: "/add_criminal_alert",
          builder: (context, state) => AddCriminalAlert(),
        ),
      ]
    ),
    GoRoute(
      path: '/admin_home',
      builder: (context, state) => AdminHomePage(),
    ),
    GoRoute(
      path: '/admin_emergency',
      builder: (context, state) => AdminEmergencyPage(),
    ),
    GoRoute(
      path: '/admin_alert',
      builder: (context, state) => AdminCriminalAlertsPage(),
    ),
    GoRoute(
      path: '/admin_fir',
      builder: (context, state) => AdminFIRPage(), 
      routes: [
        GoRoute(
          path: '/admin_fir_details',
          builder: (context, state) => AdminFirDetailsPage(),
        ),
      ]
    ),
    GoRoute(path: '/ai-chat', builder: (context, state) => ChatScreen()),
  ],
);
