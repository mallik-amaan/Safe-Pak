import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safepak/features/fir/domain/use_cases/delete_fir_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/get_firs_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/get_my_fir_usecase.dart';
import 'package:safepak/features/fir/domain/use_cases/update_fir_usecase.dart';

import '../../domain/entities/fir_entity.dart';
import '../../domain/use_cases/submit_fir_usecase.dart';

part 'fir_state.dart';

class FirCubit extends Cubit<FirState> {
  final SubmitFirUsecase submitFIRUseCase;
  final GetFirsUsecase getFIRsUseCase;
  final GetMyFirsUsecase getMyFIRsUseCase;
  final UpdateFirUsecase updateFIRUseCase;
  final DeleteFirUsecase deleteFIRUseCase;

  FirCubit({
    required this.getFIRsUseCase,
    required this.deleteFIRUseCase,
    required this.updateFIRUseCase,
    required this.submitFIRUseCase,
    required this.getMyFIRsUseCase,
  }) : super(FirInitial());

  submitFir(FIREntity fir)async{
    emit(FirLoading());
    final result = await submitFIRUseCase.call(params:fir);
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirSubmitted()),
    );
  }

  getFIRs()async{
    emit(FirLoading());
    final result = await getFIRsUseCase.call();
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirLoaded(r)),
    );
  }

  getMyFIR()async{
    emit(FirLoading());
    final result = await getMyFIRsUseCase.call();
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirLoaded(r)),
    );
  }

  deleteFIR(FIREntity fir)async{
    emit(FirLoading());
    final result = await deleteFIRUseCase.call(params:fir);
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirDeleted()),
    );
  }

  updateFIR(FIREntity fir)async{
    emit(FirLoading());
    final result = await updateFIRUseCase.call(params:fir);
    result.fold(
      (l) => emit(FirError(l.message)),
      (r) => emit(FirUpdated()),
    );
  }
}
