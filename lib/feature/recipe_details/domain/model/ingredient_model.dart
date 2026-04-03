class IngredientItem {
  String name;
  String subtitle;
  String qty;
  String unit;

  IngredientItem({
    required this.name,
    this.subtitle = '',
    required this.qty,
    required this.unit,
  });
}
