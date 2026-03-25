import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recepieapp/feature/add_recipe/presentation/widgets/user_avatar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────────
// RECIPE DETAIL PAGE
// ─────────────────────────────────────────────────────────────────────────────
class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  // Sample data — replace with actual model from navigation args
  final String _tag = 'FAMILY FAVORITE';
  final String _title = 'Slow-Roasted Heirloom Tomato Pasta';
  final String _time = '45 mins';
  final String _serves = '4 People';
  final String _level = 'Easy';
  final String _personalNote =
      '"This was the first dish Patti taught me when the summer tomatoes were almost too ripe to eat. The secret is never to rush the roasting."';
  final String _noteAuthor = "AMMA'S PERSONAL NOTES";

  List<IngredientItem> _ingredients = [
    IngredientItem(name: 'Heirloom Tomatoes', qty: '500', unit: 'g'),
    IngredientItem(
      name: 'Extra Virgin Olive Oil',
      subtitle: 'Cold pressed preferred',
      qty: '4',
      unit: 'tbsp',
    ),
    IngredientItem(
      name: 'Fresh Basil Leaves',
      subtitle: 'Torn by hand',
      qty: '1',
      unit: 'cup',
    ),
  ];

  List<CookingStep> _steps = [
    CookingStep(
      heading: 'Prepare & Roast',
      description:
          'Preheat your oven to 200°C. Toss the tomatoes with olive oil, crushed garlic, and a pinch of sea salt in a large roasting pan.',
      hasTimer: true,
      timerMinutes: 20,
    ),
    CookingStep(
      heading: 'The Pasta Base',
      description:
          'While tomatoes roast, boil a large pot of salted water. Cook the pasta until just before al dente. Reserve one cup of pasta water.',
    ),
    CookingStep(
      heading: 'Combine & Emulsify',
      description:
          'Fold the roasted tomatoes into the pasta. Add reserved water and basil. Stir vigorously until a glossy sauce forms.',
    ),
  ];

  // ── Open ingredient edit bottom sheet ──────────────────────────────────────
  void _openEditIngredients() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditIngredientsSheet(
        ingredients: List.from(
          _ingredients.map(
            (e) => IngredientItem(
              name: e.name,
              subtitle: e.subtitle,
              qty: e.qty,
              unit: e.unit,
            ),
          ),
        ),
        onSave: (updated) => setState(() => _ingredients = updated),
      ),
    );
  }

  // ── Open cooking steps edit bottom sheet ───────────────────────────────────
  void _openEditSteps() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EditStepsSheet(
        steps: List.from(
          _steps.map(
            (e) => CookingStep(
              heading: e.heading,
              description: e.description,
              hasTimer: e.hasTimer,
              timerMinutes: e.timerMinutes,
            ),
          ),
        ),
        onSave: (updated) => setState(() => _steps = updated),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF3D3A8C),
              size: 16,
            ),
          ),
        ),
        title: Text(
          "Amma's Notebook",
          style: tt.titleMedium?.copyWith(
            color: const Color(0xFF3D3A8C),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: UserAvatar()),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero header ─────────────────────────────────────────────
                _HeroHeader(
                  tag: _tag,
                  title: _title,
                  time: _time,
                  serves: _serves,
                  level: _level,
                  tt: tt,
                ),

                const SizedBox(height: 20),

                // ── Personal note card ──────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _NoteCard(
                    note: _personalNote,
                    author: _noteAuthor,
                    tt: tt,
                  ),
                ),

                const SizedBox(height: 28),

                // ── Ingredients section ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ingredients',
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openEditIngredients,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.shopping_basket_outlined,
                              color: Color(0xFF3D3A8C),
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Edit list',
                              style: tt.bodyMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                ...List.generate(_ingredients.length, (i) {
                  final ing = _ingredients[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: _IngredientTile(
                      index: i + 1,
                      ingredient: ing,
                      tt: tt,
                    ),
                  );
                }),

                const SizedBox(height: 28),

                // ── Cooking Steps section ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cooking Steps',
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      GestureDetector(
                        onTap: _openEditSteps,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF3D3A8C),
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Edit steps',
                              style: tt.bodyMedium?.copyWith(
                                color: const Color(0xFF3D3A8C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _CookingStepsList(steps: _steps, tt: tt),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),

          // ── Start Cooking sticky button
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: _StartCookingButton(tt: tt),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HERO HEADER
// ─────────────────────────────────────────────────────────────────────────────
class _HeroHeader extends StatelessWidget {
  final String tag, title, time, serves, level;
  final TextTheme tt;

  const _HeroHeader({
    required this.tag,
    required this.title,
    required this.time,
    required this.serves,
    required this.level,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4ECDC4), Color(0xFF2A7B9B)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dish illustration placeholder
              Center(
                child: Container(
                  width: 110,
                  height: 110,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    color: Color(0xFF4ECDC4),
                    size: 54,
                  ),
                ),
              ),

              // Tag pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3A8C).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: tt.bodySmall?.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Title
              Text(
                title,
                style: tt.headlineLarge?.copyWith(
                  color: Colors.white,
                  height: 1.2,
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 18),

              // Meta row
              Row(
                children: [
                  _MetaChip(
                    icon: Icons.access_time_rounded,
                    label: 'TIME',
                    value: time,
                    tt: tt,
                  ),
                  const SizedBox(width: 20),
                  _MetaChip(
                    icon: Icons.people_outline_rounded,
                    label: 'SERVES',
                    value: serves,
                    tt: tt,
                  ),
                  const SizedBox(width: 20),
                  _MetaChip(
                    icon: Icons.star_border_rounded,
                    label: 'LEVEL',
                    value: level,
                    tt: tt,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final TextTheme tt;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: tt.bodySmall?.copyWith(
            color: Colors.white60,
            fontSize: 10,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 14),
            const SizedBox(width: 4),
            Text(
              value,
              style: tt.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _NoteCard extends StatelessWidget {
  final String note, author;
  final TextTheme tt;
  const _NoteCard({required this.note, required this.author, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -4,
            right: 0,
            child: Text(
              '"',
              style: TextStyle(
                fontSize: 80,
                color: const Color(0xFF3D3A8C).withOpacity(0.1),
                height: 1,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note,
                style: tt.bodyMedium?.copyWith(
                  color: const Color(0xFF4A4A6A),
                  height: 1.7,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 1.5,
                    color: const Color(0xFF9090AA),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    author,
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF9090AA),
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INGREDIENT TILE
// ─────────────────────────────────────────────────────────────────────────────
class _IngredientTile extends StatelessWidget {
  final int index;
  final IngredientItem ingredient;
  final TextTheme tt;

  const _IngredientTile({
    required this.index,
    required this.ingredient,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '$index',
                style: tt.bodyMedium?.copyWith(
                  color: const Color(0xFF3D3A8C),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ingredient.name,
                  style: tt.bodyMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (ingredient.subtitle.isNotEmpty)
                  Text(
                    ingredient.subtitle,
                    style: tt.bodySmall?.copyWith(
                      color: const Color(0xFF9090AA),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '${ingredient.qty} ${ingredient.unit}',
            style: tt.bodyMedium?.copyWith(
              color: const Color(0xFF3D3A8C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COOKING STEPS LIST (with timeline)
// ─────────────────────────────────────────────────────────────────────────────
class _CookingStepsList extends StatelessWidget {
  final List<CookingStep> steps;
  final TextTheme tt;

  const _CookingStepsList({required this.steps, required this.tt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        final isLast = i == steps.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline
              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3D3A8C),
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
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: const Color(0xFFDDDCF0),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        step.heading,
                        style: tt.titleMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        step.description,
                        style: tt.bodyMedium?.copyWith(
                          color: const Color(0xFF6B6B8A),
                          height: 1.6,
                        ),
                      ),
                      if (step.hasTimer && step.timerMinutes > 0) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEDFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.timer_outlined,
                                color: Color(0xFF3D3A8C),
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'SET TIMER ${step.timerMinutes} MIN',
                                style: tt.bodySmall?.copyWith(
                                  color: const Color(0xFF3D3A8C),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// START COOKING BUTTON
// ─────────────────────────────────────────────────────────────────────────────
class _StartCookingButton extends StatelessWidget {
  final TextTheme tt;
  const _StartCookingButton({required this.tt});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: SizedBox(
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D3A8C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.play_circle_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  'Start Cooking',
                  style: tt.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EDIT INGREDIENTS BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────
class _EditIngredientsSheet extends StatefulWidget {
  final List<IngredientItem> ingredients;
  final ValueChanged<List<IngredientItem>> onSave;

  const _EditIngredientsSheet({
    required this.ingredients,
    required this.onSave,
  });

  @override
  State<_EditIngredientsSheet> createState() => _EditIngredientsSheetState();
}

class _EditIngredientsSheetState extends State<_EditIngredientsSheet> {
  late List<_IngEditRow> _rows;
  static const _units = ['g', 'kg', 'ml', 'l', 'tbsp', 'tsp', 'cup', 'piece'];

  @override
  void initState() {
    super.initState();
    _rows = widget.ingredients
        .map(
          (e) => _IngEditRow(
            nameCtrl: TextEditingController(text: e.name),
            subtitleCtrl: TextEditingController(text: e.subtitle),
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
      r.subtitleCtrl.dispose();
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
            subtitle: r.subtitleCtrl.text.trim(),
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
          color: Color(0xFFF4F3FB),
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
                color: const Color(0xFFCCCCDD),
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
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  TextButton(
                    onPressed: _save,
                    child: Text(
                      'Save',
                      style: tt.labelLarge?.copyWith(
                        color: const Color(0xFF3D3A8C),
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
                            _IngEditRow(
                              nameCtrl: TextEditingController(),
                              subtitleCtrl: TextEditingController(),
                              qtyCtrl: TextEditingController(),
                              unit: 'g',
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        label: const Text('Add Ingredient'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF3D3A8C),
                          side: const BorderSide(color: Color(0xFF3D3A8C)),
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
                          color: const Color(0xFF3D3A8C).withOpacity(0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _sheetField(
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
                        _sheetField(row.subtitleCtrl, 'Note (optional)', tt),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Qty
                            SizedBox(
                              width: 80,
                              child: _sheetField(
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
                                    color: const Color(0xFFF4F3FB),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xFFE0DEF7),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: row.unit,
                                      isExpanded: true,
                                      style: tt.bodySmall?.copyWith(
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

// ─────────────────────────────────────────────────────────────────────────────
// EDIT STEPS BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────
class _EditStepsSheet extends StatefulWidget {
  final List<CookingStep> steps;
  final ValueChanged<List<CookingStep>> onSave;

  const _EditStepsSheet({required this.steps, required this.onSave});

  @override
  State<_EditStepsSheet> createState() => _EditStepsSheetState();
}

class _EditStepsSheetState extends State<_EditStepsSheet> {
  late List<_StepEditRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = widget.steps
        .map(
          (e) => _StepEditRow(
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
          color: Color(0xFFF4F3FB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCCCCDD),
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
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  TextButton(
                    onPressed: _save,
                    child: Text(
                      'Save',
                      style: tt.labelLarge?.copyWith(
                        color: const Color(0xFF3D3A8C),
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
                        _StepEditRow(
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
                      foregroundColor: const Color(0xFF3D3A8C),
                      side: const BorderSide(color: Color(0xFF3D3A8C)),
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
                          color: const Color(0xFF3D3A8C).withOpacity(0.04),
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
                                color: Color(0xFF3D3A8C),
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
                                  color: const Color(0xFF9090AA),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.drag_handle_rounded,
                              color: Color(0xFF9090AA),
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
                        _sheetField(
                          row.headingCtrl,
                          'Heading (e.g., Prepare & Roast)',
                          tt,
                        ),
                        const SizedBox(height: 8),
                        // Description
                        _sheetField(
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
                                      activeColor: const Color(0xFF3D3A8C),
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
                                      color: const Color(0xFF4A4A6A),
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
                                        child: _sheetField(
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
                                          color: const Color(0xFF6B6B8A),
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

// ─────────────────────────────────────────────────────────────────────────────
// EDIT ROW MODELS
// ─────────────────────────────────────────────────────────────────────────────
class _IngEditRow {
  TextEditingController nameCtrl;
  TextEditingController subtitleCtrl;
  TextEditingController qtyCtrl;
  String unit;

  _IngEditRow({
    required this.nameCtrl,
    required this.subtitleCtrl,
    required this.qtyCtrl,
    required this.unit,
  });
}

class _StepEditRow {
  TextEditingController headingCtrl;
  TextEditingController descCtrl;
  bool hasTimer;
  TextEditingController timerCtrl;

  _StepEditRow({
    required this.headingCtrl,
    required this.descCtrl,
    required this.hasTimer,
    required this.timerCtrl,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// SHARED: Sheet text field
// ─────────────────────────────────────────────────────────────────────────────
Widget _sheetField(
  TextEditingController ctrl,
  String hint,
  TextTheme tt, {
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF4F3FB),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFE0DEF7)),
    ),
    child: TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: tt.bodyMedium?.copyWith(color: const Color(0xFF1A1A2E)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: tt.bodySmall?.copyWith(color: const Color(0xFFBBBBCC)),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
      ),
    ),
  );
}
