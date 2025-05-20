import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safepak/features/emeregency_sos/domain/entities/emergency_contact_entity.dart';

import '../../domain/use_cases/add_emergency_contact_usecase.dart';
import '../../domain/use_cases/get_emergency_contact_usecase.dart';
import '../../domain/use_cases/delete_contact_usecase.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  final AddEmergencyContactUseCase addEmergencyContactUseCase;
  final GetEmergencyContactUseCase getEmergencyContactsUseCase;
  final DeleteContactUseCase deleteEmergencyContactUseCase;

  EmergencyCubit({
    required this.addEmergencyContactUseCase,
    required this.getEmergencyContactsUseCase,
    required this.deleteEmergencyContactUseCase,
  }) : super(EmergencyInitial());

  Future<void> addEmergencyContact(EmergencyContactEntity contact) async {
    emit(EmergencyLoading());
    final result = await addEmergencyContactUseCase(params: contact);
    result.fold(
      (failure) => emit(EmergencyError(failure.message)),
      (_) => emit(EmergencyContactAdded()),
    );
  }

  Future<void> getEmergencyContacts() async {
    emit(EmergencyLoading());
    final result = await getEmergencyContactsUseCase();
    result.fold(
      (failure) => emit(EmergencyError(failure.message)),
      (contacts) => emit(EmergencyContactsLoaded(contacts)),
    );
  }

  Future<void> deleteContact(EmergencyContactEntity contact) async {
    emit(EmergencyLoading());
    final result = await deleteEmergencyContactUseCase(params: contact);
    result.fold(
      (failure) => emit(EmergencyError(failure.message)),
      (_) async{
        await getEmergencyContacts();
      }
    );
  }
}
