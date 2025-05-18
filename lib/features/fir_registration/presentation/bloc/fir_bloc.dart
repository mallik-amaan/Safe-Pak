// lib/features/fir/bloc/fir_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/fir_entity.dart';
import '../../domain/use_cases/submit_fir_usecase.dart';
import 'fir_event.dart';
import 'fir_state.dart';

class FIRBloc extends Bloc<FIREvent, FIRState> {
  final SubmitFIRUseCase submitFIRUseCase;

  FIRBloc({required this.submitFIRUseCase}) : super(FIRState.initial()) {
    on<FIRComplaintTypeChanged>((event, emit) {
      emit(state.copyWith(complaintType: event?.complaintType));
    });

    on<FIRDescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<FIRLocationChanged>((event, emit) {
      emit(state.copyWith(location: event.location));
    });

    on<FIREvidenceAdded>((event, emit) {
      emit(state.copyWith(evidencePaths: event.evidencePaths));
    });

    on<FIRSubmitRequested>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isSuccess: false, errorMessage: null));

      final fir = FIREntity(
        complaintType: state.complaintType,
        description: state.description,
        location: state.location,
        dateTime: state.dateTime,
        evidencePaths: state.evidencePaths,
      );

      final result = await submitFIRUseCase(fir);

      result.fold(
            (failure) => emit(state.copyWith(isSubmitting: false, errorMessage: failure.message)),
            (_) => emit(state.copyWith(isSubmitting: false, isSuccess: true)),
      );
    });
  }
}
