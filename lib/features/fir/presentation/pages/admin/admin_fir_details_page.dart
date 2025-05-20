import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:safepak/core/common/widgets/button_widget.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/fir/domain/entities/fir_entity.dart';
import 'package:shimmer/shimmer.dart';
import '../../cubit/fir_cubit.dart';

class AdminFirDetailsPage extends StatefulWidget {
  const AdminFirDetailsPage({super.key});

  @override
  State<AdminFirDetailsPage> createState() => _AdminFirDetailsPageState();
}

class _AdminFirDetailsPageState extends State<AdminFirDetailsPage> {
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final firEntity = GoRouter.of(context).state.extra as FIREntity;
    // Initialize _selectedStatus with valid status
    const validStatuses = ['Pending', 'In Progress', 'Resolved', 'Closed'];
    _selectedStatus ??= validStatuses.contains(firEntity.status) ? firEntity.status : 'Pending';

    return BlocListener<FirCubit, FirState>(
      listener: (context, state) {
        if (state is FirUpdated) {
          Fluttertoast.showToast(
            msg: 'FIR status updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Delay pop to show updated status
          Future.delayed(const Duration(milliseconds: 500), () {
            context.pop();
          });
        }
        if (state is FirError) {
          Fluttertoast.showToast(
            msg: 'Error updating FIR: ${state.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: BlocBuilder<FirCubit, FirState>(
        builder: (context, state) {

          final isLoading = state is FirLoading;

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'FIR Details',
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FIR Details',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Manage FIR details',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow(context, 'FIR ID', firEntity.firId!),
                    const SizedBox(height: 12),
                    _buildInfoRow(context, 'Complaint Type', firEntity.complaintType!),
                    const SizedBox(height: 12),
                    _buildInfoRow(context, 'Location', firEntity.location!),
                    const SizedBox(height: 12),
                    _buildInfoRow(context, 'Description', firEntity.description!),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      'Filed On',
                      DateFormat('MMM dd, yyyy HH:mm').format(firEntity.dateTime!),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Current Status',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: _selectedStatus,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                        DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                        DropdownMenuItem(value: 'Resolved', child: Text('Resolved')),
                        DropdownMenuItem(value: 'Closed', child: Text('Closed')),
                      ],
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedStatus = value;
                              });
                            },
                      style: Theme.of(context).textTheme.bodyMedium,
                      underline: Container(
                        height: 1,
                        color: AppColors.lightGrey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Evidence',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    firEntity.evidencePaths!.isEmpty
                        ? Text(
                            'No evidence provided',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                          )
                        : SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: firEntity.evidencePaths!.length,
                              itemBuilder: (context, index) {
                                final path = firEntity.evidencePaths![index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: path,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, url, progress) {
                                        return Shimmer(
                                          direction: ShimmerDirection.ltr,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.grey[300]!,
                                              Colors.grey[100]!,
                                              Colors.grey[300]!,
                                            ],
                                          ),
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, error, stackTrace) {
                                        return Container(
                                          width: 100,
                                          height: 100,
                                          color: AppColors.lightGrey,
                                          child: const Icon(
                                            Icons.broken_image,
                                            color: Colors.grey,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                    const SizedBox(height: 24),
                    ButtonWidget(
                      content: isLoading
                          ? const Center(
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                colors: [Colors.white],
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Update Status',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_selectedStatus != null) {
                                context.read<FirCubit>().updateFIR(
                                      firEntity.copyWith(status: _selectedStatus),
                                    );
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Please select a status',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
              ),
        ),
      ],
    );
  }
}