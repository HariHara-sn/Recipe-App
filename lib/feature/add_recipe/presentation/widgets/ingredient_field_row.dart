import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recepieapp/utils/constants/app_colors.dart';

class IngredientRow {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController qtyCtrl = TextEditingController();
  String unit = 'tbsp';
}

class IngredientFieldRow extends StatefulWidget {
  final IngredientRow row;
  final TextTheme tt;
  final VoidCallback? onDelete;

  const IngredientFieldRow({
    super.key,
    required this.row,
    required this.tt,
    this.onDelete,
  });

  @override
  State<IngredientFieldRow> createState() => _IngredientFieldRowState();
}

class _IngredientFieldRowState extends State<IngredientFieldRow> {
  static const _units = ['tbsp', 'tsp', 'cup', 'g', 'kg', 'ml', 'l', 'piece'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: _miniField(widget.row.nameCtrl, 'e.g., Turmeric'),
        ),
        const SizedBox(width: 6),

        Expanded(
          flex: 2,
          child: _miniField(
            widget.row.qtyCtrl,
            '2',
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        const SizedBox(width: 6),

        Expanded(
          flex: 3,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.blueShade5,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: AppColors.white,
                value: widget.row.unit,
                isExpanded: true,
                style: widget.tt.bodySmall?.copyWith(
                  color: AppColors.blackShadeText,
                ),
                icon: const Icon(
                  Icons.expand_more_rounded,
                  size: 16,
                  color: AppColors.blueShade3,
                ),
                items: _units
                    .map(
                      (u) => DropdownMenuItem(
                        value: u,
                        child: Text(
                          u,
                          style: widget.tt.bodySmall?.copyWith(
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => widget.row.unit = v!),
              ),
            ),
          ),
        ),

        const SizedBox(width: 4),

        GestureDetector(
          onTap: widget.onDelete,
          child: Icon(
            Icons.remove_circle_outline,
            size: 20,
            color: widget.onDelete != null
                ? Colors.redAccent
                : Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _miniField(
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.blueShade5,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: widget.tt.bodySmall?.copyWith(
          color: const Color(0xFF1A1A2E),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: widget.tt.bodySmall?.copyWith(
            color: AppColors.hintTextColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 13,
          ),
        ),
      ),
    );
  }
}