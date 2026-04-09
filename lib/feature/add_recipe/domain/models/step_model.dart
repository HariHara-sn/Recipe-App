class StepModel {
  final int stepNumber;
  final String heading;
  final String description;
  final bool hasTimer;
  final int timerMinutes;

  const StepModel({
    required this.stepNumber,
    required this.heading,
    required this.description,
    this.hasTimer = false,
    this.timerMinutes = 0,
  });

  Map<String, dynamic> toMap() => {
    'stepNumber': stepNumber,
    'heading': heading,
    'description': description,
    'hasTimer': hasTimer,
    'timerMinutes': timerMinutes,
  };

  factory StepModel.fromMap(Map<String, dynamic> map) => StepModel(
    stepNumber: map['stepNumber'] as int,
    heading: map['heading'] as String,
    description: map['description'] as String,
    hasTimer: map['hasTimer'] as bool? ?? false,
    timerMinutes: map['timerMinutes'] as int? ?? 0,
  );
}
