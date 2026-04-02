class RecipeData {
  final String id;
  final String title;
  final String author; // e.g. "AMMA", "PATTI"
  final List<String> ingredients; // lowercase, trimmed
  final String time;
  final String level;
  final String description;
  final String? ammaTip;
  final String imageUrl;

  const RecipeData({
    required this.id,
    required this.title,
    required this.author,
    required this.ingredients,
    required this.time,
    required this.level,
    required this.description,
    this.ammaTip,
    required this.imageUrl,
  });
}
