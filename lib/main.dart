
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safepak/app_router.dart';
import 'package:safepak/core/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';
import 'package:safepak/features/fir_registration/presentation/cubit/fir_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization failed: $e");
  }
  initializeDependencies();

  runApp(const MyApp());
}

ThemeData appTheme = ThemeData(
  primaryColor: Colors.black,
  highlightColor: Colors.white,
  shadowColor: Colors.green
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthenticationCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<FirCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Safe Pak',
        theme: AppTheme.appTheme,
      ),
    );
  }
}
