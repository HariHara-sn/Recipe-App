import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constants/constants.dart';



class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const _linkedIn = AppConstants.linkedInUrl;

  Future<void> _launchLinkedIn() async {
    final uri = Uri.parse(_linkedIn);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F3FB),
      body: CustomScrollView(
        slivers: [
          // ── App Bar ────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF2A2672),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(),
            ),
            title: const Text(
              'About Us',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'serif',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),

          // ── Body ───────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Slogans ─────────────────────────────────────────
                  _SloganRow(),

                  const SizedBox(height: 32),

                  // ── About section ────────────────────────────────────
                  _SectionCard(
                    emoji: '🌸',
                    title: 'About the Project',
                    child: const _AboutText(),
                  ),

                  const SizedBox(height: 20),

                  // ── Key Features ─────────────────────────────────────
                  _SectionCard(
                    emoji: '✨',
                    title: 'Key Features',
                    child: const _FeaturesList(),
                  ),

                  const SizedBox(height: 20),

                  // ── Our Motive ───────────────────────────────────────
                  _SectionCard(
                    emoji: '🎯',
                    title: 'Our Motive',
                    child: const _MotiveContent(),
                  ),

                  const SizedBox(height: 20),

                  // ── Use Cases ────────────────────────────────────────
                  _SectionCard(
                    emoji: '🍲',
                    title: 'Use Cases',
                    child: const _UseCasesList(),
                  ),

                  const SizedBox(height: 20),

                  // ── What Makes Us Special ────────────────────────────
                  _SectionCard(
                    emoji: '🚀',
                    title: 'What Makes Us Special',
                    child: const _SpecialList(),
                  ),

                  const SizedBox(height: 20),

                  // ── Comparison table ─────────────────────────────────
                  _SectionCard(
                    emoji: '🔄',
                    title: 'Compared to Other Apps',
                    child: const _ComparisonTable(),
                  ),

                  const SizedBox(height: 20),

                  // ── Vision ───────────────────────────────────────────
                  _VisionCard(),

                  const SizedBox(height: 32),

                  // ── Developer card ───────────────────────────────────
                  _DeveloperCard(onTap: _launchLinkedIn),

                  const SizedBox(height: 40),
                ],
              ),
            ),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A2672), Color(0xFF4A3FA0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // decorative circles
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 56),
                // App name with serif display style
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Amma\n',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      TextSpan(
                        text: 'Recipe Notebook',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFD0CEF0),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '📓  Preserve · Cook · Remember',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                    letterSpacing: 1,
                  ),
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
// SLOGAN ROW
// ─────────────────────────────────────────────────────────────────────────────
class _SloganRow extends StatelessWidget {
  final _slogans = const [
    'Cook smarter\nwith what you have.',
    'No more\n"what to cook?" moments.',
    'Write it.\nSave it. Cook it.',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _slogans.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => Container(
          width: 148,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3D3A8C), Color(0xFF5A57C0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            _slogans[i],
            style: const TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION CARD WRAPPER
// ─────────────────────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String emoji;
  final String title;
  final Widget child;

  const _SectionCard({
    required this.emoji,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Georgia',
                  color: Color(0xFF2A2672),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFEEEDFA), thickness: 1.5),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ABOUT TEXT
// ─────────────────────────────────────────────────────────────────────────────
class _AboutText extends StatelessWidget {
  const _AboutText();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Amma Recipe Notebook is a digital home for traditional cooking memories. '
      'It is designed to help home cooks preserve, organize, and rediscover their recipes '
      '— just like how recipes were once written in notebooks, passed from amma, patti, '
      'and athai across generations.\n\n'
      'This app blends traditional cooking culture with modern technology, making it easier '
      'to store recipes and find what to cook using the ingredients already available at home.',
      style: TextStyle(
        color: Color(0xFF4A4A6A),
        fontSize: 14.5,
        height: 1.7,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FEATURES LIST
// ─────────────────────────────────────────────────────────────────────────────
class _FeaturesList extends StatelessWidget {
  const _FeaturesList();

  static const _features = [
    (
      '📖',
      'Digital Recipe Notebook',
      'Store recipes in a simple, clean format that feels like writing in a personal diary.',
    ),
    (
      '🥕',
      'Ingredient-Based Recommendations',
      'Enter ingredients like tomato, potato, and instantly get recipe suggestions from your collection.',
    ),
    (
      '🎤',
      'Voice Recipe Entry',
      'Add recipes by speaking — perfect for quick and easy input while cooking.',
    ),
    (
      '🔍',
      'Smart Search',
      'Find recipes by name, ingredients, or category in seconds.',
    ),
    (
      '📅',
      'Daily Cooking Suggestions',
      'Get ideas on what to cook based on your usage and preferences.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _features
          .map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEDFA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(f.$1, style: const TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.$2,
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            color: Color(0xFF2A2672),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          f.$3,
                          style: const TextStyle(
                            color: Color(0xFF6B6B8A),
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MOTIVE CONTENT
// ─────────────────────────────────────────────────────────────────────────────
class _MotiveContent extends StatelessWidget {
  const _MotiveContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Our goal is to preserve the emotional and cultural value of home cooking while making it accessible in a modern way.',
          style: TextStyle(color: Color(0xFF4A4A6A), fontSize: 14.5, height: 1.7),
        ),
        const SizedBox(height: 12),
        _SubHeading('Many traditional recipes are:'),
        const SizedBox(height: 6),
        ...[
          'Forgotten over time',
          'Written on paper and lost',
          'Hard to organize and reuse',
        ].map((t) => _BulletItem(text: t, negative: true)),
        const SizedBox(height: 10),
        _SubHeading('We aim to:'),
        const SizedBox(height: 6),
        ...[
          'Digitally preserve these recipes',
          'Make cooking easier and more intuitive',
          'Help users decide what to cook with what they already have',
        ].map((t) => _BulletItem(text: t)),
      ],
    );
  }
}

class _SubHeading extends StatelessWidget {
  final String text;
  const _SubHeading(this.text);

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2A2672),
          fontWeight: FontWeight.w700,
          fontSize: 13.5,
        ),
      );
}

class _BulletItem extends StatelessWidget {
  final String text;
  final bool negative;
  const _BulletItem({required this.text, this.negative = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, left: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            negative ? '✗  ' : '✓  ',
            style: TextStyle(
              color: negative ? const Color(0xFFD64545) : const Color(0xFF3D8C6A),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4A4A6A),
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// USE CASES LIST
// ─────────────────────────────────────────────────────────────────────────────
class _UseCasesList extends StatelessWidget {
  const _UseCasesList();

  static const _cases = [
    ('👩‍🍳', 'Home cooks storing family recipes'),
    ('👵', 'Elders who prefer simple, voice-based interaction'),
    ('🧑‍🎓', 'Students or bachelors deciding what to cook with limited ingredients'),
    ('👨‍👩‍👧', 'Families sharing recipes across generations'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _cases
          .map(
            (c) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Text(c.$1, style: const TextStyle(fontSize: 22)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      c.$2,
                      style: const TextStyle(
                        color: Color(0xFF4A4A6A),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SPECIAL LIST
// ─────────────────────────────────────────────────────────────────────────────
class _SpecialList extends StatelessWidget {
  const _SpecialList();

  static const _items = [
    (
      '❤️',
      'Emotion-Driven Design',
      'Unlike typical recipe apps, we focus on personal and family recipes, not just generic internet content.',
    ),
    (
      '🧠',
      'Smart Ingredient Matching',
      'Instead of searching for recipes manually, the app thinks for you and suggests dishes based on what you have.',
    ),
    (
      '🎤',
      'Built for Real Kitchens',
      'Voice input and simple UI make it practical while cooking — not just for browsing.',
    ),
    (
      '📓',
      'Notebook Experience',
      'The app feels like a personal recipe diary, not a complex platform.',
    ),
    (
      '🇮🇳',
      'Cultural Relevance',
      'Designed with Indian home cooking in mind — supporting styles like Amma, Patti, Athai.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.$1, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.$2,
                          style: const TextStyle(
                            fontFamily: 'Georgia',
                            color: Color(0xFF2A2672),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: Color(0xFF6B6B8A),
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPARISON TABLE
// ─────────────────────────────────────────────────────────────────────────────
class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable();

  @override
  Widget build(BuildContext context) {
    const headers = ['Feature', 'Typical Apps', 'Amma Notebook'];
    const rows = [
      ['Focus', 'Online recipes', 'Personal & family'],
      ['Input', 'Typing only', 'Voice + simple input'],
      ['Search', 'Keyword-based', 'Ingredient-based'],
      ['Experience', 'Generic', 'Emotional & cultural'],
      ['Use', 'Browsing', 'Daily cooking decisions'],
    ];

    return Table(
      border: TableBorder.all(color: const Color(0xFFE0DEF7), width: 1),
      columnWidths: const {
        0: FlexColumnWidth(1.4),
        1: FlexColumnWidth(1.4),
        2: FlexColumnWidth(1.4),
      },
      children: [
        // Header row
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFF3D3A8C)),
          children: headers
              .map(
                (h) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 10),
                  child: Text(
                    h,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
        // Data rows
        ...rows.asMap().entries.map((entry) {
          final isEven = entry.key.isEven;
          return TableRow(
            decoration: BoxDecoration(
              color: isEven
                  ? const Color(0xFFF4F3FB)
                  : Colors.white,
            ),
            children: entry.value
                .asMap()
                .entries
                .map(
                  (cell) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 9),
                    child: Text(
                      cell.value,
                      style: TextStyle(
                        color: cell.key == 2
                            ? const Color(0xFF3D3A8C)
                            : const Color(0xFF4A4A6A),
                        fontSize: 12,
                        fontWeight: cell.key == 2
                            ? FontWeight.w600
                            : FontWeight.normal,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VISION CARD
// ─────────────────────────────────────────────────────────────────────────────
class _VisionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A2672), Color(0xFF4A3FA0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💡  Vision',
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'To become a smart cooking companion that not only stores recipes but also helps every home cook answer the daily question:',
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Text(
              '👉  "What should I cook today?"',
              style: TextStyle(
                fontFamily: 'Georgia',
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DEVELOPER CARD
// ─────────────────────────────────────────────────────────────────────────────
class _DeveloperCard extends StatelessWidget {
  final VoidCallback onTap;

  const _DeveloperCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D3A8C).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '@developer',
            style: TextStyle(
              color: Color(0xFF9090AA),
              fontSize: 11,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF3D3A8C), Color(0xFF6B68CC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'H',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Hari Hara Sudhan S',
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Color(0xFF1A1A2E),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Software Developer',
            style: TextStyle(
              color: Color(0xFF6B6B8A),
              fontSize: 13.5,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF0A66C2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Connect on LinkedIn',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
