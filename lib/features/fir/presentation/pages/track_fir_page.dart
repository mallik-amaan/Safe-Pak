import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/dependency_injection.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/features/fir/presentation/widgets/user_fir_card.dart';

import '../cubit/fir_cubit.dart';

class TrackFirPage extends StatefulWidget {
  const TrackFirPage({super.key});

  @override
  State<TrackFirPage> createState() => _TrackFirPageState();
}

class _TrackFirPageState extends State<TrackFirPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FirCubit>()..getFIRs(),
      child: Scaffold(
        appBar: AppBar(
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            setState(() {
              context.read<FirCubit>().getMyFIR();
            });
          },
          child: BlocBuilder<FirCubit, FirState>(
            builder: (context, state) {
              if (state is FirLoading) {
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
              if (state is FirError) {
                Fluttertoast.showToast(
                  msg: 'Error fetching FIRs: ${state.message}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                return const Center(child: Text('Error loading FIRs'));
              }
              if (state is FirLoaded && state.firs.isEmpty) {
                return const Center(child: Text('No FIRs found'));
              }
              if (state is FirLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Track Your FIRs',
                          style:
                              Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Monitor your submitted complaints',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.firs.length,
                          itemBuilder: (context, index) {
                            final fir = state.firs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.push(
                                    '/fir_details',
                                    extra: fir,
                                  );
                                },
                                child: UserFirCard(
                                  id: fir.firId!,
                                  complaintType: fir.complaintType!,
                                  description: fir.description!,
                                  location: fir.location!,
                                  dateTime: fir.dateTime.toString(),
                                  status: fir.status!,
                                  evidencePaths: fir.evidencePaths!,
                                ),
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
      ),
    );
  }
}