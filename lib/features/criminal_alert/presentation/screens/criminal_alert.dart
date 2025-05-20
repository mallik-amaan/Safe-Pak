import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:safepak/features/criminal_alert/presentation/cubit/alert_cubit.dart';
import 'package:safepak/features/criminal_alert/presentation/widgets/criminal_card.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CriminalAlertPage extends StatelessWidget {
  const CriminalAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AlertCubit>()..fetchMyAlerts(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            context.read<AlertCubit>().fetchMyAlerts();
            return Future.delayed(const Duration(milliseconds: 500));
          },
          child: Column(
            children: [
             Text(
                  "Criminal Alerts",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text("Nearby suspicious activities",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<AlertCubit, AlertState>(
                  builder: (context, state) {
                    if (state is AlertLoading) {
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                            colors: [AppColors.primaryColor],
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }
                    if (state is AlertError) {
                      Fluttertoast.showToast(
                        msg: 'Error fetching alerts: ${state.message}',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return const Center(child: Text('Error loading alerts'));
                    }
                    if (state is AlertsLoaded && state.alerts.isEmpty) {
                      return const Center(child: Text('No alerts found in your area'));
                    }
                    if (state is AlertsLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              
                              const SizedBox(height: 16),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.alerts.length,
                                itemBuilder: (context, index) {
                                  final alert = state.alerts[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: CriminalCard(
                                      label: alert.title,
                                      description: alert.description,
                                      location: alert.city,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}