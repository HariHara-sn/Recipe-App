import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/Theme/app_images.dart';
import 'package:recepieapp/utils/widgets/BottomNavigation/floating_navigationbar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────────────────────
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

const List<Recipe> recentRecipes = [
  Recipe(
    tag: 'AMMA',
    title: 'Mixed Veg Sa...',
    subtitle: '',
    imageUrl: NetImg.mixedVeg,
  ),
  Recipe(
    tag: 'ATHAI',
    title: 'Kushpu Idly',
    subtitle: '',
    imageUrl: NetImg.dosa,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNav = 0;
  int _selectedFilter = 0;
  final List<String> _filters = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.softlavenderWhiteBackground,
      extendBody: true, // lets content flow under the floating nav
      body: Stack(
        children: [
          // ── Scrollable content ──────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // ── App Bar ──────────────────────────────────────────────────
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
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(NetImg.avatar),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Hero headline ─────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  child: Text(
                    'What shall we\ncook today?',
                    style: tt.headlineLarge?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              // ── Search bar ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3D3A8C).withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        const Icon(
                          Icons.search,
                          color: Color(0xFFAAAAAA),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Search recipes or ingredients...',
                            style: tt.bodyMedium?.copyWith(
                              color: const Color(0xFFAAAAAA),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Filter chips ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (ctx, i) {
                        final active = i == _selectedFilter;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedFilter = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: active
                                  ? const Color(0xFF3D3A8C)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              _filters[i],
                              style: tt.labelLarge?.copyWith(
                                fontSize: 14,
                                color: active
                                    ? Colors.white
                                    : const Color(0xFF4A4A6A),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // ── Section: Today's Suggestion ───────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Suggestion",
                        style: tt.headlineMedium?.copyWith(
                          color: const Color(0xFF1A1A2E),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'View Archive',
                        style: tt.bodyMedium?.copyWith(
                          color: const Color(0xFF3D3A8C),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Hero Recipe Card ──────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _HeroRecipeCard(tt: tt),
                ),
              ),

              // ── List Recipes ──────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    children: [
                      _ListRecipeCard(
                        tag: 'PATTI',
                        title: 'Traditional Pulao',
                        subtitle: 'Fragrant basmati rice with spices...',
                        imageUrl: NetImg.pulao,
                        tt: tt,
                      ),
                      const SizedBox(height: 12),
                      _ListRecipeCard(
                        tag: 'ATHAI',
                        title: 'Crispy Ghee\nRoast',
                        subtitle: 'Perfectly crisp dosa with...',
                        imageUrl: NetImg.dosa,
                        tt: tt,
                      ),
                    ],
                  ),
                ),
              ),

              // ── Amma's Tip ────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: _AmmaTipCard(tt: tt),
                ),
              ),

              // ── Section: Recent Additions ─────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                  child: Text(
                    'Recent Additions',
                    style: tt.headlineMedium?.copyWith(
                      color: const Color(0xFF1A1A2E),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _RecentCard(
                          tag: 'AMMA',
                          title: 'Mixed Veg Sa...',
                          imageUrl: NetImg.mixedVeg,
                          tt: tt,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _RecentCard(
                          tag: 'ATHAI',
                          title: 'Elaneer Paya...',
                          imageUrl: NetImg.elaneer,
                          tt: tt,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom padding so content isn't behind nav bar
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // ── Floating Blur Bottom Nav ──────────────────────────────────────
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: FloatingNavBar(
              selected: _selectedNav,
              onTap: (i) => setState(() => _selectedNav = i),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HERO RECIPE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _HeroRecipeCard extends StatelessWidget {
  final TextTheme tt;
  const _HeroRecipeCard({required this.tt});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              NetImg.tangyRasam,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : _shimmerBox(double.infinity, 280),
            ),
            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC1A1A2E)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            // Content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3A8C).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'AMMA',
                      style: tt.bodySmall?.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tangy Tomato Rasam',
                    style: tt.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        color: Colors.white70,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '15 mins',
                        style: tt.bodySmall?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(width: 14),
                      const Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.white70,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Easy',
                        style: tt.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LIST RECIPE CARD
// ─────────────────────────────────────────────────────────────────────────────
class _ListRecipeCard extends StatelessWidget {
  final String tag, title, subtitle, imageUrl;
  final TextTheme tt;
  const _ListRecipeCard({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : _shimmerBox(72, 72),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  style: tt.bodySmall?.copyWith(
                    color: const Color(0xFF3D3A8C),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: tt.titleMedium?.copyWith(
                    color: const Color(0xFF1A1A2E),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: tt.bodySmall?.copyWith(color: const Color(0xFF9090AA)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AMMA'S TIP CARD
// ─────────────────────────────────────────────────────────────────────────────
class _AmmaTipCard extends StatelessWidget {
  final TextTheme tt;
  const _AmmaTipCard({required this.tt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: const Border(
          left: BorderSide(color: Color(0xFF3D3A8C), width: 3.5),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
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
                "Amma's Tip",
                style: tt.labelLarge?.copyWith(
                  color: const Color(0xFF3D3A8C),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '"Always roast the mustard seeds until they pop, it releases the hidden soul of the spices!"',
            style: tt.bodyMedium?.copyWith(
              color: const Color(0xFF4A4A6A),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// RECENT CARD
// ─────────────────────────────────────────────────────────────────────────────
class _RecentCard extends StatelessWidget {
  final String tag, title, imageUrl;
  final TextTheme tt;
  const _RecentCard({
    required this.tag,
    required this.title,
    required this.imageUrl,
    required this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),

      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,

                loadingBuilder:
                    (
                      _,
                      child,
                      progress,
                    ) => // Hari remove this when you add the local image. bcoze local image dont need the progress
                    progress == null
                    ? child
                    : _shimmerBox(double.infinity, 150),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tag,
            style: tt.bodySmall?.copyWith(
              color: const Color(0xFF3D3A8C),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: tt.titleMedium?.copyWith(
              color: const Color(0xFF1A1A2E),
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────
Widget _shimmerBox(double width, double height) {
  return Container(
    width: width,
    height: height,
    color: const Color(0xFFE8E7F5),
  );
}
