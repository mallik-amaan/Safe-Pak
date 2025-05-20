import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/fir/presentation/widgets/admin/admin_fir_card.dart';

import '../../../../../dependency_injection.dart';
import '../../cubit/fir_cubit.dart';

class AdminFIRPage extends StatelessWidget {
  const AdminFIRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FirCubit>()..getFIRs(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Admin FIR Dashboard',
          ),
          elevation: 0,
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            context.read<FirCubit>().getFIRs();
            return Future.delayed(const Duration(milliseconds: 500));
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
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.firs.length,
                      itemBuilder: (context, index) {
                        final fir = state.firs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              context.push('/admin_fir/admin_fir_details',
                                  extra: fir);
                            },
                            child: AdminFirCard(
                              label: fir.complaintType!,
                              description: fir.description!,
                              location: fir.location!,
                            ),
                          ),
                        );
                      },
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
