import 'package:flutter/material.dart';

class ProfileQuoteCard extends StatelessWidget {
  final String quote;

  const ProfileQuoteCard({
    super.key,
    this.quote =
        '"Continuing the legacy, one pinch of salt at a time."',
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              quote,
              style: tt.bodyLarge?.copyWith(
                color: const Color(0xFF3D3A8C),
                fontStyle: FontStyle.italic,
                height: 1.6,
              ),
            ),
          ),
          Positioned(
            top: -14,
            left: 16,
            child: Text(
              '"',
              style: TextStyle(
                fontSize: 52,
                color: const Color(0xFF3D3A8C).withOpacity(0.25),
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
