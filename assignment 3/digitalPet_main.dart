import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const CosyCatApp());
}

class CosyCatApp extends StatelessWidget {
  const CosyCatApp({super.key});

  @override
  Widget build(BuildContext context) {
    const palette = Catppuccin.mocha;
    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: palette.lavender,
      onPrimary: palette.crust,
      secondary: palette.pink,
      onSecondary: palette.crust,
      surface: palette.mantle,
      onSurface: palette.text,
      error: palette.maroon,
      onError: palette.crust,
      primaryContainer: palette.surface,
      onPrimaryContainer: palette.text,
      secondaryContainer: palette.surfaceVariant,
      onSecondaryContainer: palette.text,
      tertiary: palette.green,
      onTertiary: palette.crust,
      tertiaryContainer: palette.surface,
      onTertiaryContainer: palette.text,
      onSurfaceVariant: palette.text,
      outline: palette.overlay,
      outlineVariant: palette.overlay,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: palette.crust,
      onInverseSurface: palette.text,
      inversePrimary: palette.peach,
    );

    return MaterialApp(
      title: 'Milo the Cat',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: palette.text,
          displayColor: palette.text,
        ),
        scaffoldBackgroundColor: palette.base,
      ),
      home: const CatHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Catppuccin {
  final Color crust;
  final Color base;
  final Color mantle;
  final Color surface;
  final Color surfaceVariant;
  final Color overlay;
  final Color text;
  final Color lavender;
  final Color pink;
  final Color peach;
  final Color green;
  final Color maroon;

  const Catppuccin._({
    required this.crust,
    required this.base,
    required this.mantle,
    required this.surface,
    required this.surfaceVariant,
    required this.overlay,
    required this.text,
    required this.lavender,
    required this.pink,
    required this.peach,
    required this.green,
    required this.maroon,
  });

  static const mocha = Catppuccin._(
    crust: Color(0xFF11111B),
    base: Color(0xFF1E1E2E),
    mantle: Color(0xFF181825),
    surface: Color(0xFF313244),
    surfaceVariant: Color(0xFF45475A),
    overlay: Color(0xFF6C7086),
    text: Color(0xFFE6E9EF),
    lavender: Color(0xFFB4BEFE),
    pink: Color(0xFFF5C2E7),
    peach: Color(0xFFFAB387),
    green: Color(0xFFA6E3A1),
    maroon: Color(0xFFEBA0AC),
  );
}

class CatHomePage extends StatefulWidget {
  const CatHomePage({super.key});

  @override
  State<CatHomePage> createState() => _CatHomePageState();
}

class _CatHomePageState extends State<CatHomePage> {
  final palette = Catppuccin.mocha;
  double fullness = 0.65;
  double energy = 0.6;
  double joy = 0.7;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        fullness = (fullness - 0.04).clamp(0.0, 1.0);
        energy = (energy - 0.03).clamp(0.0, 1.0);
        joy = (joy - 0.02).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _feed() {
    setState(() {
      fullness = (fullness + 0.22).clamp(0.0, 1.0);
      joy = (joy + 0.08).clamp(0.0, 1.0);
      energy = (energy + 0.05).clamp(0.0, 1.0);
    });
  }

  void _play() {
    setState(() {
      joy = (joy + 0.18).clamp(0.0, 1.0);
      energy = (energy - 0.07).clamp(0.0, 1.0);
      fullness = (fullness - 0.05).clamp(0.0, 1.0);
    });
  }

  void _nap() {
    setState(() {
      energy = (energy + 0.2).clamp(0.0, 1.0);
      fullness = (fullness - 0.04).clamp(0.0, 1.0);
      joy = (joy + 0.05).clamp(0.0, 1.0);
    });
  }

  double get _mood => (fullness + energy + joy) / 3;

  String get _moodLine {
    if (_mood > 0.8) {
      return 'Milo purrs like a warm kettle.';
    } else if (_mood > 0.55) {
      return 'Milo is comfy and watching you closely.';
    } else if (_mood > 0.3) {
      return 'Milo flicks their tail, hinting for attention.';
    } else {
      return 'Milo curls up quietly. Maybe some treats would help?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [palette.mantle, palette.base, palette.crust],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Milo',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: palette.lavender,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'your catppuccin companion',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: palette.pink,
                            letterSpacing: 1.2,
                          ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: palette.surface.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: palette.lavender.withValues(alpha: 0.3), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: palette.crust.withValues(alpha: 0.5),
                            blurRadius: 24,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 220,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CustomPaint(
                                painter: CatPainter(mood: _mood, palette: palette),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _moodLine,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: palette.text,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    PetStatBar(
                      label: 'fullness',
                      value: fullness,
                      color: palette.peach,
                      icon: Icons.ramen_dining_rounded,
                    ),
                    const SizedBox(height: 12),
                    PetStatBar(
                      label: 'energy',
                      value: energy,
                      color: palette.lavender,
                      icon: Icons.bedtime_rounded,
                    ),
                    const SizedBox(height: 12),
                    PetStatBar(
                      label: 'joy',
                      value: joy,
                      color: palette.green,
                      icon: Icons.toys_rounded,
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _PetButton(
                          label: 'Feed',
                          icon: Icons.local_cafe_rounded,
                          color: palette.peach,
                          onTap: _feed,
                        ),
                        _PetButton(
                          label: 'Play',
                          icon: Icons.waving_hand_rounded,
                          color: palette.pink,
                          onTap: _play,
                        ),
                        _PetButton(
                          label: 'Nap',
                          icon: Icons.self_improvement_rounded,
                          color: palette.lavender,
                          onTap: _nap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PetStatBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final IconData icon;

  const PetStatBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Catppuccin.mocha;
    return Container(
      decoration: BoxDecoration(
        color: palette.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: palette.overlay.withValues(alpha: 0.35), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 12,
                color: color,
                backgroundColor: palette.surfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text('${(value * 100).round()}%'),
        ],
      ),
    );
  }
}

class _PetButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _PetButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: color.withValues(alpha: 0.82),
            foregroundColor: Catppuccin.mocha.crust,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(label),
        ),
      ),
    );
  }
}

class CatPainter extends CustomPainter {
  final double mood;
  final Catppuccin palette;

  CatPainter({required this.mood, required this.palette});

  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()..color = palette.surfaceVariant;
    final bellyPaint = Paint()..color = palette.surface.withValues(alpha: 0.7);
    final earPaint = Paint()..color = palette.lavender;
    final innerEarPaint = Paint()..color = palette.pink.withValues(alpha: 0.7);
    final facePaint = Paint()..color = palette.surfaceVariant;
    final blushPaint = Paint()..color = palette.pink.withValues(alpha: 0.4);
    final outline = Paint()
      ..color = palette.crust.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;

    final bodyRect = Rect.fromCenter(
      center: Offset(width / 2, height * 0.62),
      width: width * 0.72,
      height: height * 0.56,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, Radius.circular(width * 0.36)),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, Radius.circular(width * 0.36)),
      outline,
    );

    final bellyRect = Rect.fromCenter(
      center: Offset(width / 2, height * 0.7),
      width: width * 0.45,
      height: height * 0.36,
    );
    canvas.drawOval(bellyRect, bellyPaint);

    final headCenter = Offset(width / 2, height * 0.32);
    final headRadius = width * 0.32;
    canvas.drawCircle(headCenter, headRadius, facePaint);
    canvas.drawCircle(headCenter, headRadius, outline);

    final earHeight = headRadius * 1.1;
    final earWidth = headRadius * 0.9;

    Path earPath(double direction) {
      final baseX = headCenter.dx + direction * headRadius * 0.7;
      final baseY = headCenter.dy - headRadius * 0.4;
      return Path()
        ..moveTo(baseX, baseY)
        ..lineTo(baseX + direction * earWidth * 0.3, baseY - earHeight)
        ..lineTo(baseX + direction * earWidth, baseY)
        ..close();
    }

    final leftEar = earPath(-1);
    final rightEar = earPath(1);
    canvas.drawPath(leftEar, earPaint);
    canvas.drawPath(rightEar, earPaint);
    canvas.drawPath(leftEar, outline);
    canvas.drawPath(rightEar, outline);

    Path innerEar(double direction) {
      final baseX = headCenter.dx + direction * headRadius * 0.6;
      final baseY = headCenter.dy - headRadius * 0.15;
      final tipX = headCenter.dx + direction * headRadius * 0.25;
      final tipY = headCenter.dy - earHeight * 0.55;
      return Path()
        ..moveTo(baseX, baseY)
        ..lineTo(tipX, tipY)
        ..lineTo(baseX + direction * headRadius * 0.25, baseY)
        ..close();
    }

    canvas.drawPath(innerEar(-1), innerEarPaint);
    canvas.drawPath(innerEar(1), innerEarPaint);

    final cheekOffset = headRadius * 0.55;
    canvas.drawCircle(headCenter.translate(-cheekOffset, headRadius * 0.2), headRadius * 0.22, blushPaint);
    canvas.drawCircle(headCenter.translate(cheekOffset, headRadius * 0.2), headRadius * 0.22, blushPaint);

    final eyeY = headCenter.dy - headRadius * 0.1;
    final eyeSpacing = headRadius * 0.6;
    final openness = (0.35 + mood * 0.35).clamp(0.25, 0.8);

    void drawEye(double direction) {
      final eyeCenter = Offset(headCenter.dx + direction * eyeSpacing / 2, eyeY);
      final eyeRect = Rect.fromCenter(
        center: eyeCenter,
        width: headRadius * 0.32,
        height: headRadius * openness,
      );
      final eyeRRect = RRect.fromRectAndRadius(eyeRect, Radius.circular(headRadius * 0.2));
      canvas.drawRRect(eyeRRect, Paint()..color = palette.crust);
      final sparkle = Rect.fromCenter(
        center: eyeCenter.translate(-direction * headRadius * 0.06, -headRadius * 0.05),
        width: headRadius * 0.12,
        height: headRadius * 0.12,
      );
      canvas.drawOval(sparkle, Paint()..color = palette.text.withValues(alpha: 0.8));
    }

    drawEye(-1);
    drawEye(1);

    final mouthPaint = Paint()
      ..color = palette.crust
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final smile = Rect.fromCenter(
      center: headCenter.translate(0, headRadius * 0.35),
      width: headRadius * 0.7,
      height: headRadius * (0.4 + 0.2 * mood),
    );
    final startAngle = math.pi * 0.15;
    final sweepAngle = math.pi - math.pi * 0.3 * (1 - mood);
    canvas.drawArc(smile, startAngle, sweepAngle, false, mouthPaint);

    final nosePaint = Paint()..color = palette.pink;
    final nosePath = Path()
      ..moveTo(headCenter.dx, headCenter.dy + headRadius * 0.1)
      ..lineTo(headCenter.dx - headRadius * 0.08, headCenter.dy + headRadius * 0.25)
      ..lineTo(headCenter.dx + headRadius * 0.08, headCenter.dy + headRadius * 0.25)
      ..close();
    canvas.drawPath(nosePath, nosePaint);
    canvas.drawPath(
      nosePath,
      Paint()
        ..color = palette.crust.withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );

    final whiskerPaint = Paint()
      ..color = palette.overlay
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final whiskerLength = headRadius * 0.9;
    final whiskerY = headCenter.dy + headRadius * 0.25;
    for (var i = -1; i <= 1; i++) {
      final angle = (i) * 0.18;
      final dx = math.cos(angle) * whiskerLength;
      final dy = math.sin(angle) * whiskerLength * 0.2;
      canvas.drawLine(
        Offset(headCenter.dx - headRadius * 0.2, whiskerY + i * headRadius * 0.05),
        Offset(headCenter.dx - headRadius * 0.2 - dx, whiskerY + i * headRadius * 0.05 - dy),
        whiskerPaint,
      );
      canvas.drawLine(
        Offset(headCenter.dx + headRadius * 0.2, whiskerY + i * headRadius * 0.05),
        Offset(headCenter.dx + headRadius * 0.2 + dx, whiskerY + i * headRadius * 0.05 - dy),
        whiskerPaint,
      );
    }

    final tailPath = Path()
      ..moveTo(bodyRect.right - width * 0.06, bodyRect.center.dy)
      ..cubicTo(
        bodyRect.right + width * 0.25,
        bodyRect.center.dy - height * (0.3 + 0.1 * (1 - mood)),
        bodyRect.right - width * 0.05,
        bodyRect.top - height * 0.02,
        bodyRect.right + width * 0.1,
        bodyRect.top + height * 0.12,
      );
    final tailPaint = Paint()
      ..color = palette.lavender
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * 0.08
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(tailPath, tailPaint);
  }

  @override
  bool shouldRepaint(covariant CatPainter oldDelegate) => oldDelegate.mood != mood;
}
