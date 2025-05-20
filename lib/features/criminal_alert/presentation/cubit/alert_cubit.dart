import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safepak/features/criminal_alert/domain/entities/criminal_alert_entity.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/add_alert_usecase.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/fetch_all_alerts_usecase.dart';
import 'package:safepak/features/criminal_alert/domain/use_cases/fetch_my_alerts_usecase.dart';

part 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  final FetchAllAlertsUsecase fetchAllAlertsUseCase;
  final FetchMyAlertsUsecase fetchMyAlertsUsecase;
  final AddAlertUsecase createAlertUseCase;

  AlertCubit({
    required this.fetchAllAlertsUseCase,
    required this.createAlertUseCase,
    required this.fetchMyAlertsUsecase,
  }) : super(AlertInitial());

  Future<void> fetchAllAlerts() async {
    emit(AlertLoading());
    final result = await fetchAllAlertsUseCase();
    result.fold(
      (failure) => emit(AlertError(failure.message)),
      (alerts) => emit(AlertsLoaded(alerts)),
    );
  }

  Future<void> fetchMyAlerts() async {
    emit(AlertLoading());
    final result = await fetchMyAlertsUsecase();
    result.fold(
      (failure) => emit(AlertError(failure.message)),
      (alerts) => emit(AlertsLoaded(alerts)),
    );
  }

  Future<void> createAlert(CriminalAlertEntity alert) async {
  
    emit(AlertLoading());
    final result = await createAlertUseCase(params:alert);
    result.fold(
      (failure) => emit(AlertError(failure.message)),
      (_) => emit(AlertAdded()),
    );
  }
}