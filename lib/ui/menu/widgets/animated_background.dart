import 'dart:math';

import 'package:flutter/material.dart';

class MenuBackground extends StatelessWidget {
  final Widget child;

  const MenuBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFADD8E6), // Light blue
            Color(0xFFFFD1DC), // Light pink
            Color(0xFFFFFACD), // Light yellow
          ],
        ),
      ),
      child: Stack(
        children: [
          const _AnimatedBackground(),
          child,
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Bubble> _bubbles = List.generate(20, (i) => _Bubble());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _BubblePainter(_bubbles, _controller.value),
          child: Container(),
        );
      },
    );
  }
}

class _Bubble {
  final double x = Random().nextDouble();
  final double size = 20 + Random().nextDouble() * 30;
  final double speed = 0.2 + Random().nextDouble() * 0.8;
  final Color color = Colors
      .primaries[Random().nextInt(Colors.primaries.length)]
      .withValues(alpha: 0.08);
}

class _BubblePainter extends CustomPainter {
  final List<_Bubble> bubbles;
  final double progress;
  _BubblePainter(this.bubbles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    for (final bubble in bubbles) {
      final y = size.height * ((bubble.x + progress * bubble.speed) % 1.0);
      final x = size.width * bubble.x;
      final paint = Paint()..color = bubble.color;
      canvas.drawCircle(Offset(x, y), bubble.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
