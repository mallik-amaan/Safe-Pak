import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safepak/app_router.dart';
import 'package:safepak/core/configs/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/authentication/presentation/bloc/auth_cubit/authentication_cubit.dart';
import 'package:safepak/features/criminal_alert/presentation/cubit/alert_cubit.dart';
import 'package:safepak/features/fir/presentation/cubit/fir_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/emeregency_sos/presentation/cubit/emergency_cubit.dart';
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
  await Supabase.initialize(
    url: 'https://mxtrvsnkfdsvoqjzsbox.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14dHJ2c25rZmRzdm9xanpzYm94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2MzM1MjUsImV4cCI6MjA2MzIwOTUyNX0.OPRN_rtZyLrUBb_1jMHGjd0qjxiVDLstfwvZn2NvAEc',
  );
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
        BlocProvider(
          create: (context) => sl<EmergencyCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<AlertCubit>(),
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
