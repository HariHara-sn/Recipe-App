import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/feature/recipe_details/domain/model/edit_row_model.dart';
import 'package:recepieapp/feature/recipe_details/domain/model/ingredient_model.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/sheet_textfield_widget.dart';

class EditIngredientsSheet extends StatefulWidget {
  final List<IngredientItem> ingredients;
  final ValueChanged<List<IngredientItem>> onSave;

  const EditIngredientsSheet({super.key, 
    required this.ingredients,
    required this.onSave,
  });

  @override
  State<EditIngredientsSheet> createState() => _EditIngredientsSheetState();
}

class _EditIngredientsSheetState extends State<EditIngredientsSheet> {
  late List<IngEditRow> _rows;
  static const _units = ['g', 'kg', 'ml', 'l', 'tbsp', 'tsp', 'cup', 'piece'];

  @override
  void initState() {
    super.initState();
    _rows = widget.ingredients
        .map(
          (e) => IngEditRow(
            nameCtrl: TextEditingController(text: e.name),
            qtyCtrl: TextEditingController(text: e.qty),
            unit: e.unit,
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    for (final r in _rows) {
      r.nameCtrl.dispose();
      r.qtyCtrl.dispose();
    }
    super.dispose();
  }

  void _save() {
    final updated = _rows
        .where((r) => r.nameCtrl.text.trim().isNotEmpty)
        .map(
          (r) => IngredientItem(
            name: r.nameCtrl.text.trim(),
            qty: r.qtyCtrl.text.trim().isEmpty ? '0' : r.qtyCtrl.text.trim(),
            unit: r.unit,
          ),
        )
        .toList();
    widget.onSave(updated);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.blueShade5,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyIcon,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Ingredients',
                    style: tt.headlineMedium?.copyWith(
                      color: AppColors.textMain,
                    ),
                  ),
                  TextButton(
                    onPressed: _save,
                    child: Text(
                      'Save',
                      style: tt.labelLarge?.copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // List
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: _rows.length + 1,
                itemBuilder: (_, i) {
                  if (i == _rows.length) {
                    // Add button
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: OutlinedButton.icon(
                        onPressed: () => setState(
                          () => _rows.add(
                            IngEditRow(
                              nameCtrl: TextEditingController(),
                              qtyCtrl: TextEditingController(),
                              unit: 'g',
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Ingredient'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryBlue,
                          side: const BorderSide(color: AppColors.primaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                      ),
                    );
                  }
                  final row = _rows[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBlue.withOpacity(0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: sheetField(
                                row.nameCtrl,
                                'Ingredient name',
                                tt,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => setState(() => _rows.removeAt(i)),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Qty
                            SizedBox(
                              width: 80,
                              child: sheetField(
                                row.qtyCtrl,
                                'Qty',
                                tt,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Unit dropdown
                            Expanded(
                              child: StatefulBuilder(
                                builder: (ctx, setInner) => Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.blueShade5,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.blueShade4,
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: row.unit,
                                      isExpanded: true,
                                      style: tt.bodySmall?.copyWith(
                                        color: AppColors.textMain,
                                      ),
                                      icon: const Icon(
                                        Icons.expand_more_rounded,
                                        size: 16,
                                        color: AppColors.textGrey,
                                      ),
                                      items: _units
                                          .map(
                                            (u) => DropdownMenuItem(
                                              value: u,
                                              child: Text(u),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (v) {
                                        setInner(() => row.unit = v!);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}