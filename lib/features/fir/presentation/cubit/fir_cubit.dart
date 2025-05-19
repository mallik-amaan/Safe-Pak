import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/fir_entity.dart';
import '../../domain/use_cases/submit_fir_usecase.dart';

part 'fir_state.dart';

class FirCubit extends Cubit<FirState> {
  final SubmitFirUsecase submitFIRUseCase;
  FirCubit({
    required this.submitFIRUseCase,
  }) : super(FirInitial());

  submitFir(FIREntity fir)async{
    emit(FirLoading());
    final result = await submitFIRUseCase.call(params:fir);
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirSubmitted()),
    );
  }
}
