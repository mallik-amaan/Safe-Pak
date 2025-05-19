part of 'fir_cubit.dart';

sealed class FirState extends Equatable {
  const FirState();
}

final class FirInitial extends FirState {
   @override
  List<Object> get props => [];
}

final class FirLoading extends FirState {
   @override
  List<Object> get props => [];
}

final class FirSubmitted extends FirState {
   @override
  List<Object> get props => [];
}


final class FirError extends FirState {
  final String message;
  const FirError(this.message);
   @override
  List<Object> get props => [message];
}