
import 'package:equatable/equatable.dart';

class FIREvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FIRComplaintTypeChanged extends FIREvent {
  final String complaintType;

  FIRComplaintTypeChanged(this.complaintType);

  @override
  List<Object?> get props => [complaintType];
}

class FIRDescriptionChanged extends FIREvent {
  final String description;

  FIRDescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class FIRLocationChanged extends FIREvent {
  final String location;

  FIRLocationChanged(this.location);

  @override
  List<Object?> get props => [location];
}

class FIREvidenceAdded extends FIREvent {
  final List<String> evidencePaths;

  FIREvidenceAdded(this.evidencePaths);

  @override
  List<Object?> get props => [evidencePaths];
}

class FIRSubmitRequested extends FIREvent {}

class ResetFIRFeedback extends FIREvent {}
