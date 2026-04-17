import 'package:flutter/material.dart';
import 'package:recepieapp/core/theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  final List<Color>? placeholderColors;

  final Widget? foreground;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderColors,
    this.foreground,
  });

  static const List<Color> _defaultGradient = [
    AppColors.tealAccent,
    AppColors.tealDark,
  ];

  @override
  Widget build(BuildContext context) {
    final effectiveUrl = url?.trim() ?? '';
    final colors = placeholderColors ?? _defaultGradient;

    Widget image;
    if (effectiveUrl.isEmpty) {
      image = _GradientPlaceholder(
        width: width,
        height: height,
        colors: colors,
      );
    } else {
      image = Image.network(
        effectiveUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return _ShimmerLoader(width: width, height: height);
        },
        errorBuilder: (_, _, _) =>
            _GradientPlaceholder(width: width, height: height, colors: colors),
      );
    }

    Widget result = image;

    if (foreground != null) {
      result = Stack(children: [image, foreground!]);
    }

    if (borderRadius != null) {
      result = ClipRRect(borderRadius: borderRadius!, child: result);
    }

    return result;
  }
}

class _ShimmerLoader extends StatefulWidget {
  final double? width;
  final double? height;

  const _ShimmerLoader({this.width, this.height});

  @override
  State<_ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<_ShimmerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value, 0),
              colors: const [
                AppColors.shimmerBase,
                AppColors.shimmerHighlight,
                AppColors.shimmerBase,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.restaurant_menu_rounded,
              color: AppColors.primaryBlue.withOpacity(0.15),
              size: (widget.height ?? 80) * 0.3,
            ),
          ),
        );
      },
    );
  }
}

// GRADIENT PLACEHOLDER (error / empty URL)
class _GradientPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Color> colors;

  const _GradientPlaceholder({this.width, this.height, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.restaurant_menu_rounded,
          color: Colors.white.withOpacity(0.4),
          size: (height ?? 80) * 0.3,
        ),
      ),
    );
  }
}
