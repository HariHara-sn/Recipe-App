class StepModel {
  final int stepNumber;
  final String heading;
  final String description;

  const StepModel({
    required this.stepNumber,
    required this.heading,
    required this.description,
  });

  Map<String, dynamic> toMap() => {
    'stepNumber': stepNumber,
    'heading': heading,
    'description': description,
  };

  factory StepModel.fromMap(Map<String, dynamic> map) => StepModel(
    stepNumber: map['stepNumber'] as int,
    heading: map['heading'] as String,
    description: map['description'] as String,
  );
}
