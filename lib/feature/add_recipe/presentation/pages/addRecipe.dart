import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ADD RECIPE PAGE
// ─────────────────────────────────────────────────────────────────────────────
class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // 1. Image
  File? _dishImage;

  // 2. Recipe title
  final _titleController = TextEditingController();

  // 3. Ingredients
  final List<_IngredientRow> _ingredients = [_IngredientRow()];

  // 4. Source link
  final _sourceLinkController = TextEditingController();

  // 5. Servings
  int _servings = 1;

  // 6. Cooking steps
  final List<_StepRow> _steps = [_StepRow(), _StepRow()];

  // ── Pick image ──────────────────────────────────────────────────────────────
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _dishImage = File(picked.path));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _sourceLinkController.dispose();
    for (final ing in _ingredients) {
      ing.nameCtrl.dispose();
      ing.qtyCtrl.dispose();
    }
    for (final step in _steps) {
      step.headingCtrl.dispose();
      step.descCtrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FB),
      extendBody: true,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App bar
              SliverToBoxAdapter(
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.menu_book_rounded,
                              color: Color(0xFF3D3A8C),
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Amma's Notebook",
                              style: tt.titleMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const UserAvatar(),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Page title ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
                  child: Text(
                    'New Family Secret',
                    style: tt.headlineLarge?.copyWith(
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Text(
                    'Preserve a new memory for the heirloom collection.',
                    style: tt.bodyMedium?.copyWith(
                      color: const Color(0xFF6B6B8A),
                    ),
                  ),
                ),
              ),

              // ── White card ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D3A8C).withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── 1. Image picker ───────────────────────────────
                          _ImagePicker(
                            image: _dishImage,
                            onTap: _pickImage,
                            tt: tt,
                          ),

                          const SizedBox(height: 24),

                          // ── 2. Recipe title ───────────────────────────────
                          _fieldLabel('RECIPE TITLE', tt),
                          const SizedBox(height: 8),
                          _StyledTextField(
                            controller: _titleController,
                            hint: 'e.g., Sunday Mutton Curry',
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 24),

                          // ── 3. Ingredients ────────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _fieldLabel('INGREDIENTS', tt),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3D3A8C),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.mic_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Header row
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  'Ingredient name',
                                  style: tt.bodySmall?.copyWith(
                                    color: const Color(0xFF9090AA),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Qty',
                                  style: tt.bodySmall?.copyWith(
                                    color: const Color(0xFF9090AA),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Unit',
                                  style: tt.bodySmall?.copyWith(
                                    color: const Color(0xFF9090AA),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 28),
                            ],
                          ),
                          const SizedBox(height: 6),

                          ...List.generate(_ingredients.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _IngredientFieldRow(
                                row: _ingredients[i],
                                tt: tt,
                                onDelete: _ingredients.length > 1
                                    ? () => setState(
                                        () => _ingredients.removeAt(i),
                                      )
                                    : null,
                              ),
                            );
                          }),

                          // Add ingredient button
                          GestureDetector(
                            onTap: () => setState(
                              () => _ingredients.add(_IngredientRow()),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(
                                    0xFF3D3A8C,
                                  ).withOpacity(0.3),
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: Color(0xFF3D3A8C),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Add Ingredient',
                                    style: tt.labelLarge?.copyWith(
                                      color: const Color(0xFF3D3A8C),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── 4. Source link ────────────────────────────────
                          _fieldLabel('SOURCE LINK', tt),
                          const SizedBox(height: 8),
                          _StyledTextField(
                            controller: _sourceLinkController,
                            hint: 'YouTube or Blog URL...',
                            prefixIcon: Icons.link_rounded,
                            keyboardType: TextInputType.url,
                          ),

                          const SizedBox(height: 24),

                          // ── 5. Servings ───────────────────────────────────
                          _fieldLabel('SERVINGS', tt),
                          const SizedBox(height: 8),
                          _ServingsDropdown(
                            value: _servings,
                            tt: tt,
                            onChanged: (v) => setState(() => _servings = v!),
                          ),

                          const SizedBox(height: 24),

                          // ── 6. Cooking steps ──────────────────────────────
                          _fieldLabel('THE METHOD', tt),
                          const SizedBox(height: 12),

                          ...List.generate(_steps.length, (i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _CookingStepField(
                                index: i + 1,
                                row: _steps[i],
                                tt: tt,
                                onDelete: _steps.length > 1
                                    ? () => setState(() => _steps.removeAt(i))
                                    : null,
                              ),
                            );
                          }),

                          // Add step button
                          GestureDetector(
                            onTap: () => setState(() => _steps.add(_StepRow())),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEDFA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF3D3A8C),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Add Step',
                                    style: tt.labelLarge?.copyWith(
                                      color: const Color(0xFF3D3A8C),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // ── Submit button ─────────────────────────────────
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3D3A8C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Add to Recipe Notebook',
                                    style: tt.labelLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ── Patti's tip ───────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: const Border(
                        left: BorderSide(color: Color(0xFF3D3A8C), width: 3.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline_rounded,
                              color: Color(0xFF3D3A8C),
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Patti's Note",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: const Color(0xFF3D3A8C),
                                    fontSize: 13,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Don't forget to mention if the heat should be low or high; that's where the soul of the curry lives.",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color(0xFF4A4A6A),
                                height: 1.6,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // ── Floating blur bottom nav ──────────────────────────────────────
          const Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: _FloatingNavBar(selected: 2),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DATA ROWS
// ─────────────────────────────────────────────────────────────────────────────
class _IngredientRow {
  final nameCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  String unit = 'tbsp';
}

class _StepRow {
  final headingCtrl = TextEditingController();
  final descCtrl = TextEditingController();
}

// ─────────────────────────────────────────────────────────────────────────────
// IMAGE PICKER WIDGET
// ─────────────────────────────────────────────────────────────────────────────
class _ImagePicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final TextTheme tt;

  const _ImagePicker({
    required this.image,
    required this.onTap,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                Image.file(image!, fit: BoxFit.cover)
              else
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEDFA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3D3A8C).withOpacity(0.12),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Color(0xFF3D3A8C),
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add a Photo',
                        style: tt.labelLarge?.copyWith(
                          color: const Color(0xFF3D3A8C),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Capture the final dish',
                        style: tt.bodySmall?.copyWith(
                          color: const Color(0xFF9090AA),
                        ),
                      ),
                    ],
                  ),
                ),
              if (image != null)
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INGREDIENT FIELD ROW
// ─────────────────────────────────────────────────────────────────────────────
class _IngredientFieldRow extends StatefulWidget {
  final _IngredientRow row;
  final TextTheme tt;
  final VoidCallback? onDelete;

  const _IngredientFieldRow({
    required this.row,
    required this.tt,
    this.onDelete,
  });

  @override
  State<_IngredientFieldRow> createState() => _IngredientFieldRowState();
}

class _IngredientFieldRowState extends State<_IngredientFieldRow> {
  static const _units = ['tbsp', 'tsp', 'cup', 'g', 'kg', 'ml', 'l', 'piece'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Name
        Expanded(
          flex: 4,
          child: _miniField(widget.row.nameCtrl, 'e.g., Turmeric'),
        ),
        const SizedBox(width: 6),
        // Qty — integers only
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
        // Unit dropdown
        Expanded(
          flex: 3,
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3FB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: widget.row.unit,
                isExpanded: true,
                style: widget.tt.bodySmall?.copyWith(
                  color: const Color(0xFF1A1A2E),
                ),
                icon: const Icon(
                  Icons.expand_more_rounded,
                  size: 16,
                  color: Color(0xFF9090AA),
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
        // Delete
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
        color: const Color(0xFFF4F3FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: widget.tt.bodySmall?.copyWith(color: const Color(0xFF1A1A2E)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: widget.tt.bodySmall?.copyWith(
            color: const Color(0xFFBBBBCC),
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

// ─────────────────────────────────────────────────────────────────────────────
// SERVINGS DROPDOWN
// ─────────────────────────────────────────────────────────────────────────────
class _ServingsDropdown extends StatelessWidget {
  final int value;
  final TextTheme tt;
  final ValueChanged<int?> onChanged;

  const _ServingsDropdown({
    required this.value,
    required this.tt,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0DEF7)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isExpanded: true,
          style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
          icon: const Icon(
            Icons.expand_more_rounded,
            color: Color(0xFF3D3A8C),
            size: 20,
          ),
          items: List.generate(
            7,
            (i) => DropdownMenuItem(
              value: i + 1,
              child: Text(
                i + 1 == 1 ? '1 person' : '${i + 1} people',
                style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COOKING STEP FIELD
// ─────────────────────────────────────────────────────────────────────────────
class _CookingStepField extends StatelessWidget {
  final int index;
  final _StepRow row;
  final TextTheme tt;
  final VoidCallback? onDelete;

  const _CookingStepField({
    required this.index,
    required this.row,
    required this.tt,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step number bubble
        Container(
          width: 26,
          height: 26,
          margin: const EdgeInsets.only(top: 12, right: 10),
          decoration: const BoxDecoration(
            color: Color(0xFF3D3A8C),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$index',
              style: tt.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        // Fields
        Expanded(
          child: Column(
            children: [
              // Heading
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3FB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0DEF7)),
                ),
                child: TextField(
                  controller: row.headingCtrl,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Heading: e.g., Prepare the Fish',
                    hintStyle: tt.bodySmall?.copyWith(
                      color: const Color(0xFFBBBBCC),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              // Description
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3FB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0DEF7)),
                ),
                child: TextField(
                  controller: row.descCtrl,
                  maxLines: 3,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Description: e.g., Clean the fish thoroughly...',
                    hintStyle: tt.bodySmall?.copyWith(
                      color: const Color(0xFFBBBBCC),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Delete step
        if (onDelete != null)
          GestureDetector(
            onTap: onDelete,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 6),
              child: const Icon(
                Icons.remove_circle_outline,
                size: 20,
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED: Styled text field
// ─────────────────────────────────────────────────────────────────────────────
class _StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? prefixIcon;
  final TextInputType keyboardType;

  const _StyledTextField({
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3FB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0DEF7)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: tt.bodyMedium?.copyWith(color: const Color(0xFFBBBBCC)),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: const Color(0xFF9090AA), size: 18)
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED: Field label
// ─────────────────────────────────────────────────────────────────────────────
Widget _fieldLabel(String text, TextTheme tt) {
  return Text(
    text,
    style: tt.bodySmall?.copyWith(
      color: const Color(0xFF9090AA),
      fontWeight: FontWeight.w700,
      letterSpacing: 1.4,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// FLOATING BLUR BOTTOM NAV (reused from HomePage)
// ─────────────────────────────────────────────────────────────────────────────
class _FloatingNavBar extends StatelessWidget {
  final int selected;
  const _FloatingNavBar({required this.selected});

  static const _items = [
    (icon: Icons.home_rounded, label: 'HOME'),
    (icon: Icons.search_rounded, label: 'SEARCH'),
    (icon: Icons.add_circle_outline_rounded, label: 'ADD'),
    (icon: Icons.person_outline_rounded, label: 'PROFILE'),
  ];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.6), width: 1),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3D3A8C).withOpacity(0.12),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final isSelected = i == selected;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: isSelected
                      ? BoxDecoration(
                          color: const Color(0xFF3D3A8C),
                          borderRadius: BorderRadius.circular(20),
                        )
                      : null,
                  child: isSelected
                      ? Icon(item.icon, color: Colors.white, size: 24)
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item.icon,
                              color: const Color(0xFF9090AA),
                              size: 22,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: tt.bodySmall?.copyWith(
                                color: const Color(0xFF9090AA),
                                fontSize: 9,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
