// lib/features/fir/bloc/fir_state.dart

import 'package:equatable/equatable.dart';

class FIRState extends Equatable {
  final String complaintType;
  final String description;
  final String location;
  final DateTime dateTime;
  final List<String> evidencePaths;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const FIRState({
    required this.complaintType,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.evidencePaths,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  factory FIRState.initial() => FIRState(
    complaintType: '',
    description: '',
    location: '',
    dateTime: DateTime.now(),
    evidencePaths: [],
  );

  FIRState copyWith({
    String? complaintType,
    String? description,
    String? location,
    DateTime? dateTime,
    List<String>? evidencePaths,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return FIRState(
      complaintType: complaintType ?? this.complaintType,
      description: description ?? this.description,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      evidencePaths: evidencePaths ?? this.evidencePaths,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    complaintType,
    description,
    location,
    dateTime,
    evidencePaths,
    isSubmitting,
    isSuccess,
    errorMessage,
  ];
}
