import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../core/theme.dart';

class RealisticFlashlightPainter extends CustomPainter {
  final Offset? position;
  final double radius;
  final double intensity; // Battery level affects this
  final bool isFlickering; // Critical battery effect
  final double headingRadians;
  final double movementSpeed;
  final double timeSeconds;
  final double focusQuality; // 0.0-1.0 (higher = tighter hotspot)
  final double eyeAdaptation; // 0.0-1.0 (higher = brighter eyes adapted)
  final List<Offset> contactPoints;
  final double dustDensity; // 0.0-2.0

  RealisticFlashlightPainter({
    this.position,
    required this.radius,
    required this.intensity,
    this.isFlickering = false,
    this.headingRadians = -pi / 2,
    this.movementSpeed = 0.0,
    this.timeSeconds = 0.0,
    this.focusQuality = 0.7,
    this.eyeAdaptation = 1.0,
    this.contactPoints = const [],
    this.dustDensity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (position == null) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = AppTheme.pureBlack,
      );
      return;
    }

    final beamDirection = Offset(cos(headingRadians), sin(headingRadians));
    final beamCenter = position! + beamDirection * (radius * 0.34);
    final moveFactor = (movementSpeed / 650).clamp(0.0, 1.0);
    final smear = 1.0 + (moveFactor * 0.22);

    // Warm battery color shift (low battery gets warmer/yellower)
    final batteryWarmth = (1.0 - intensity).clamp(0.0, 1.0);
    final temperatureTint = Color.lerp(
      Colors.white,
      const Color(0xFFFFD38A),
      batteryWarmth * 0.8,
    )!;

    // Smooth waveform-based flicker for critical battery.
    final flickerWave = (sin((timeSeconds * 21.0) + (position!.dx * 0.03)) +
            0.5 * sin((timeSeconds * 37.0) + (position!.dy * 0.07))) /
        1.5;
    final flickerMultiplier = isFlickering
        ? (0.86 + (flickerWave * 0.14)).clamp(0.7, 1.0)
        : 1.0;

    // Eye adaptation: motion briefly darkens perceived scene and then recovers.
    final adaptedIntensity = (intensity * eyeAdaptation * flickerMultiplier)
        .clamp(0.15, 1.1);

    final beamPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(
        Rect.fromCenter(
          center: beamCenter,
          width: radius * 2.0 * smear,
          height: radius * 1.55,
        ),
      )
      ..fillType = PathFillType.evenOdd;

    final darknessOpacity = (0.97 - (adaptedIntensity * 0.28) + (moveFactor * 0.05))
        .clamp(0.54, 0.97);

    canvas.drawPath(
      beamPath,
      Paint()
        ..color = AppTheme.pureBlack.withValues(alpha: darknessOpacity)
        ..style = PaintingStyle.fill,
    );

    canvas.save();
    canvas.translate(beamCenter.dx, beamCenter.dy);
    canvas.rotate(headingRadians);
    canvas.scale(smear, 1.0);

    final coneRect = Rect.fromCenter(
      center: Offset.zero,
      width: radius * 2,
      height: radius * 1.45,
    );

    final edgeSoftness = (0.08 + (moveFactor * 0.07)).clamp(0.08, 0.18);

    final outerBeamPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Color.lerp(AppTheme.flashlightCore, temperatureTint, 0.25)!
              .withValues(alpha: 0.16 * adaptedIntensity),
          Color.lerp(AppTheme.flashlightHalo, temperatureTint, 0.40)!
              .withValues(alpha: 0.27 * adaptedIntensity),
          AppTheme.flashlightEdge.withValues(alpha: 0.14 * adaptedIntensity),
          Colors.transparent,
        ],
        stops: [0.0, 0.50 - (edgeSoftness * 0.4), 0.88 - edgeSoftness, 1.0],
      ).createShader(coneRect);

    canvas.drawOval(coneRect, outerBeamPaint);

    final hotspotTightness = ui.lerpDouble(0.58, 0.36, focusQuality) ?? 0.45;
    final hotspotRadius = radius * hotspotTightness;
    final hotspotCenter = Offset(radius * 0.08, 0);

    final hotspotPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withValues(alpha: 0.94 * adaptedIntensity),
          Color.lerp(AppTheme.flashlightCore, temperatureTint, 0.22)!
              .withValues(alpha: 0.76 * adaptedIntensity),
          AppTheme.flashlightHalo.withValues(alpha: 0.17 * adaptedIntensity),
          Colors.transparent,
        ],
        stops: const [0.0, 0.22, 0.70, 1.0],
      ).createShader(Rect.fromCircle(center: hotspotCenter, radius: hotspotRadius));

    canvas.drawCircle(hotspotCenter, hotspotRadius, hotspotPaint);

    final lensRingPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08 * adaptedIntensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * (0.022 + (0.008 * focusQuality));

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: radius * 1.3,
        height: radius * 0.95,
      ),
      lensRingPaint,
    );

    // Subtle flashlight housing shadow to simulate the torch body near lens.
    final housingShadowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black.withValues(alpha: 0.20 + (moveFactor * 0.06)),
          Colors.black.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(
        Rect.fromCenter(
          center: Offset(-radius * 0.42, 0),
          width: radius * 0.78,
          height: radius * 0.58,
        ),
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(-radius * 0.42, 0),
        width: radius * 0.78,
        height: radius * 0.58,
      ),
      housingShadowPaint,
    );

    canvas.restore();

    // Contact bloom for discovered/proximal text and props.
    for (final point in contactPoints) {
      final distance = (point - beamCenter).distance;
      if (distance > radius * 0.72) continue;
      final bloomStrength = (1.0 - (distance / (radius * 0.72))).clamp(0.0, 1.0);
      final bloomRadius = radius * (0.08 + (0.12 * bloomStrength));

      final bloomPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.22 * bloomStrength * adaptedIntensity),
            AppTheme.flashlightHalo
                .withValues(alpha: 0.13 * bloomStrength * adaptedIntensity),
            Colors.transparent,
          ],
          stops: const [0.0, 0.55, 1.0],
        ).createShader(Rect.fromCircle(center: point, radius: bloomRadius));

      canvas.drawCircle(point, bloomRadius, bloomPaint);
    }

    // Volumetric dust shafts with layered drift and parallax.
    final particleCount = (6 + (dustDensity * 12)).round();
    for (int i = 0; i < particleCount; i++) {
      final layer = (i % 3) + 1;
      final depth = layer / 3;
      final drift = timeSeconds * (8 + (6 * depth));

      final xPhase = (i * 41.7) + drift;
      final yPhase = (i * 23.3) + (drift * 0.7);

      final px = beamCenter.dx +
          (cos(xPhase * 0.12) * radius * 0.65) +
          (sin(yPhase * 0.07) * radius * 0.2);
      final py = beamCenter.dy +
          (sin(yPhase * 0.11) * radius * 0.5) +
          (cos(xPhase * 0.05) * radius * 0.2);

      final particlePos = Offset(px, py);
      final distToCenter = (particlePos - beamCenter).distance;
      if (distToCenter > radius) continue;

      final alpha = (0.04 + (0.05 * depth)) * adaptedIntensity;
      final particleRadius = 0.7 + (1.4 * depth);

      canvas.drawCircle(
        particlePos,
        particleRadius,
        Paint()..color = Colors.white.withValues(alpha: alpha.clamp(0.0, 0.14)),
      );
    }

    // Simple roughness response: occasional tiny glints within hotspot area.
    final glintSeed = ((position!.dx * 13) + (position!.dy * 7) + timeSeconds * 4).floor();
    final glintRandom = Random(glintSeed);
    final glintCount = 2 + (focusQuality * 3).round();
    for (int i = 0; i < glintCount; i++) {
      final angle = glintRandom.nextDouble() * 2 * pi;
      final dist = glintRandom.nextDouble() * radius * 0.32;
      final glintCenter = beamCenter + Offset(cos(angle) * dist, sin(angle) * dist);
      final glintSize = 0.8 + (glintRandom.nextDouble() * 1.8);
      canvas.drawCircle(
        glintCenter,
        glintSize,
        Paint()..color = Colors.white.withValues(alpha: 0.06 * adaptedIntensity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant RealisticFlashlightPainter oldDelegate) {
    return oldDelegate.position != position ||
        oldDelegate.intensity != intensity ||
        oldDelegate.isFlickering != isFlickering ||
        oldDelegate.headingRadians != headingRadians ||
        oldDelegate.movementSpeed != movementSpeed ||
        oldDelegate.timeSeconds != timeSeconds ||
        oldDelegate.focusQuality != focusQuality ||
        oldDelegate.eyeAdaptation != eyeAdaptation ||
        oldDelegate.contactPoints.length != contactPoints.length ||
        oldDelegate.dustDensity != dustDensity;
  }
}
