import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recepieapp/core/theme/app_colors.dart';
import 'package:recepieapp/feature/recipe_details/domain/model/cooking_steps_model.dart';
import 'package:recepieapp/feature/recipe_details/domain/model/edit_row_model.dart';
import 'package:recepieapp/feature/recipe_details/presentation/widgets/sheet_textfield_widget.dart';

class EditStepsSheet extends StatefulWidget {
  final List<CookingStep> steps;
  final ValueChanged<List<CookingStep>> onSave;

  const EditStepsSheet({super.key, required this.steps, required this.onSave});

  @override
  State<EditStepsSheet> createState() => _EditStepsSheetState();
}

class _EditStepsSheetState extends State<EditStepsSheet> {
  late List<StepEditRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = widget.steps
        .map(
          (e) => StepEditRow(
            headingCtrl: TextEditingController(text: e.heading),
            descCtrl: TextEditingController(text: e.description),
            hasTimer: e.hasTimer,
            timerCtrl: TextEditingController(
              text: e.timerMinutes > 0 ? '${e.timerMinutes}' : '',
            ),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    for (final r in _rows) {
      r.headingCtrl.dispose();
      r.descCtrl.dispose();
      r.timerCtrl.dispose();
    }
    super.dispose();
  }

  void _save() {
    final updated = _rows
        .where((r) => r.headingCtrl.text.trim().isNotEmpty)
        .map(
          (r) => CookingStep(
            heading: r.headingCtrl.text.trim(),
            description: r.descCtrl.text.trim(),
            hasTimer: r.hasTimer,
            timerMinutes: int.tryParse(r.timerCtrl.text.trim()) ?? 0,
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
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.97,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: AppColors.blueShade5,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyIcon,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Steps',
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
            Expanded(
              child: ReorderableListView.builder(
                scrollController: scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: _rows.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _rows.removeAt(oldIndex);
                    _rows.insert(newIndex, item);
                  });
                },
                footer: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 20),
                  child: OutlinedButton.icon(
                    onPressed: () => setState(
                      () => _rows.add(
                        StepEditRow(
                          headingCtrl: TextEditingController(),
                          descCtrl: TextEditingController(),
                          hasTimer: false,
                          timerCtrl: TextEditingController(),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add Step'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: const BorderSide(color: AppColors.primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                  ),
                ),
                itemBuilder: (_, i) {
                  final row = _rows[i];
                  return Container(
                    key: ValueKey('step_$i'),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step number + drag + delete row
                        Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryBlue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${i + 1}',
                                  style: tt.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Step ${i + 1}',
                                style: tt.bodyMedium?.copyWith(
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.drag_handle_rounded,
                              color: AppColors.textGrey,
                              size: 20,
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
                        const SizedBox(height: 10),
                        // Heading
                        sheetField(
                          row.headingCtrl,
                          'Heading (e.g., Prepare & Roast)',
                          tt,
                        ),
                        const SizedBox(height: 8),
                        // Description
                        sheetField(
                          row.descCtrl,
                          'Description...',
                          tt,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        // Timer toggle
                        StatefulBuilder(
                          builder: (ctx, setInner) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 0.85,
                                    child: Switch(
                                      value: row.hasTimer,
                                      activeColor: AppColors.primaryBlue,
                                      onChanged: (v) {
                                        setInner(() => row.hasTimer = v);
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Set a timer for this step',
                                    style: tt.bodySmall?.copyWith(
                                      color: AppColors.blackShadeText,
                                    ),
                                  ),
                                ],
                              ),
                              if (row.hasTimer)
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        child: sheetField(
                                          row.timerCtrl,
                                          'Minutes',
                                          tt,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'minutes',
                                        style: tt.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
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
