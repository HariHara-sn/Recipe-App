class Recipe {
  final String tag, title, subtitle, imageUrl;
  final String? time, difficulty;
  const Recipe({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.time,
    this.difficulty,
  });
}