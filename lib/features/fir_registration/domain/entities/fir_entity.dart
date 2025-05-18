class FIREntity {
  final String complaintType;
  final String description;
  final DateTime dateTime;
  final String location;
  final List<String>? evidencePaths;

  FIREntity({
    required this.complaintType,
    required this.description,
    required this.dateTime,
    required this.location,
    this.evidencePaths,
  });
}
