class CookingStep {
  String heading;
  String description;
  bool hasTimer;
  int timerMinutes;

  CookingStep({
    required this.heading,
    required this.description,
    this.hasTimer = false,
    this.timerMinutes = 0,
  });
}
