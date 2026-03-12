import 'dart:math';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class RealisticFlashlightPainter extends CustomPainter {
  final Offset? position;
  final double radius;
  final double intensity; // Battery level affects this
  final bool isFlickering; // Critical battery effect

  RealisticFlashlightPainter({
    this.position,
    required this.radius,
    required this.intensity,
    this.isFlickering = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (position == null) {
      // Complete darkness
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = AppTheme.pureBlack,
      );
      return;
    }

    // Create the vignette effect (darkness outside beam)
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: position!, radius: radius))
      ..fillType = PathFillType.evenOdd;

    // Paint darkness with opacity based on battery
    final darknessOpacity = 0.95 - (intensity * 0.3); // 0.65 to 0.95
    
    canvas.drawPath(
      path,
      Paint()
        ..color = AppTheme.pureBlack.withValues(alpha: darknessOpacity)
        ..style = PaintingStyle.fill,
    );

    // Inner glow (the light itself)
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.flashlightCore.withValues(alpha: 0.9 * intensity),
          AppTheme.flashlightHalo.withValues(alpha: 0.3 * intensity),
          AppTheme.flashlightEdge.withValues(alpha: 0.1 * intensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: position!, radius: radius));

    canvas.drawCircle(position!, radius, glowPaint);

    // Battery flicker effect (critical levels)
    if (isFlickering && Random().nextDouble() > 0.7) {
      canvas.drawCircle(
        position!, 
        radius * 0.9, 
        Paint()..color = AppTheme.pureBlack.withValues(alpha: 0.3),
      );
    }

    // Dust particles in light (atmospheric)
    final particlePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1 * intensity)
      ..strokeWidth = 1;
    
    for (int i = 0; i < 5; i++) {
      final angle = Random().nextDouble() * 2 * pi;
      final dist = Random().nextDouble() * radius * 0.8;
      final particlePos = position! + Offset(cos(angle) * dist, sin(angle) * dist);
      canvas.drawCircle(particlePos, 1, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant RealisticFlashlightPainter oldDelegate) {
    return oldDelegate.position != position || 
           oldDelegate.intensity != intensity ||
           oldDelegate.isFlickering != isFlickering;
  }
}
