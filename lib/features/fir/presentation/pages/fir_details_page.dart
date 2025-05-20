import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:safepak/core/configs/theme/app_colors.dart';
import 'package:safepak/features/fir/domain/entities/fir_entity.dart';

class FirDetailsPage extends StatelessWidget {
  const FirDetailsPage({super.key,});

  @override
  Widget build(BuildContext context) {
    final fir = GoRouter.of(context).state.extra as FIREntity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FIR ID: ${fir.firId}', style: Theme.of(context).textTheme.titleMedium),
            Text('Type: ${fir.complaintType}', style: Theme.of(context).textTheme.titleMedium),
            Text('Location: ${fir.location}', style: Theme.of(context).textTheme.titleMedium),
            Text('Description: ${fir.description}', style: Theme.of(context).textTheme.titleMedium),
            Text('Filed: ${DateFormat('MMM dd, yyyy HH:mm').format(fir.dateTime!)}', style: Theme.of(context).textTheme.titleMedium),
            Text('Status: ${fir.status}', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: _getStatusColor(fir))),
            if (fir.evidencePaths!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text('Evidence:', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fir.evidencePaths!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.network(fir.evidencePaths![index], width: 100, height: 100),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(FIREntity fir) {
    switch (fir.status!.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}