class IngredientModel {
  final String name;
  final double quantity;
  final String unit;

  const IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'quantity': quantity,
    'unit': unit,
  };

  factory IngredientModel.fromMap(Map<String, dynamic> map) => IngredientModel(
    name: map['name'] as String,
    quantity: (map['quantity'] as num).toDouble(),
    unit: map['unit'] as String,
  );
}
