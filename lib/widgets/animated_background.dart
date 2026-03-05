// lib/widgets/animated_background.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  final _orbData = const [
    _OrbConfig(Color(0x2D6C63FF), 700, Offset(-0.3, -0.2), 20000),
    _OrbConfig(Color(0x2438BDF8), 600, Offset(0.6, 0.2),   25000),
    _OrbConfig(Color(0x1F10B981), 500, Offset(0.1, 0.7),   18000),
    _OrbConfig(Color(0x19F472B6), 400, Offset(0.7, 0.6),   22000),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = _orbData.map((o) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: o.durationMs),
    )..repeat(reverse: true)).toList();

    _animations = List.generate(_orbData.length, (i) {
      final rand = math.Random(i * 7);
      return Tween<Offset>(
        begin: Offset(rand.nextDouble() * 0.06, rand.nextDouble() * 0.06),
        end:   Offset(-rand.nextDouble() * 0.06, rand.nextDouble() * 0.06),
      ).animate(CurvedAnimation(parent: _controllers[i], curve: Curves.easeInOut));
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Gradient base
      Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(-0.5, -0.8),
            radius: 1.8,
            colors: [Color(0xFF0C1221), AppColors.bg0],
          ),
        ),
      ),
      // Grid
      const _GridPainterWidget(),
      // Orbs
      ...List.generate(_orbData.length, (i) => AnimatedBuilder(
        animation: _animations[i],
        builder: (_, __) => Positioned(
          left: MediaQuery.of(context).size.width  * (_orbData[i].center.dx + _animations[i].value.dx),
          top:  MediaQuery.of(context).size.height * (_orbData[i].center.dy + _animations[i].value.dy),
          child: Transform.translate(
            offset: Offset(-_orbData[i].size / 2, -_orbData[i].size / 2),
            child: Container(
              width: _orbData[i].size,
              height: _orbData[i].size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_orbData[i].color, _orbData[i].color.withOpacity(0)],
                ),
              ),
            ),
          ),
        ),
      )),
      // Content
      widget.child,
    ]);
  }
}

class _OrbConfig {
  final Color color;
  final double size;
  final Offset center;
  final int durationMs;
  const _OrbConfig(this.color, this.size, this.center, this.durationMs);
}

class _GridPainterWidget extends StatelessWidget {
  const _GridPainterWidget();
  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _GridPainter(),
    size: MediaQuery.of(context).size,
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..strokeWidth = 1;
    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(_) => false;
}
