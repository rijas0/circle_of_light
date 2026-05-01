import 'package:flutter/material.dart';

import '../../data/services/quran_auth_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _authService = QuranAuthService();
  bool _isLoading = false;

  Future<void> _onConnectTap() async {
    setState(() => _isLoading = true);

    try {
      final code = await _authService.login();

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (code != null) {
        // TODO: Send 'code' to your Supabase Edge Function / Backend
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Success! Code: $code')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login cancelled')));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07120A),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanternIllustration(),
                  SizedBox(height: 48),
                  _AppTitle(),
                  SizedBox(height: 12),
                  _AppSubtitle(),
                ],
              ),
            ),
            _ConnectButton(isLoading: _isLoading, onTap: _onConnectTap),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Circle of Light',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _AppSubtitle extends StatelessWidget {
  const _AppSubtitle();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Text(
        'Build a steady rhythm of Quran reading\nand reflection through gentle, shared accountability.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 15, height: 1.6),
      ),
    );
  }
}

class _ConnectButton extends StatelessWidget {
  const _ConnectButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3D7A52),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Text(
                  'Connect with Quran Foundation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }
}

class LanternIllustration extends StatelessWidget {
  const LanternIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 280,
      child: CustomPaint(painter: _LanternPainter()),
    );
  }
}

class _LanternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final glowRadius = size.width * 0.6;

    _drawGlow(canvas, Offset(centerX, size.height * 0.45), glowRadius);
    _drawLantern(canvas, size);
  }

  void _drawGlow(Canvas canvas, Offset center, double radius) {
    final gradient = RadialGradient(
      colors: [
        const Color(0xFF4ADE80).withOpacity(0.25),
        const Color(0xFF4ADE80).withOpacity(0.12),
        const Color(0xFF4ADE80).withOpacity(0.04),
        Colors.transparent,
      ],
      stops: const [0.0, 0.4, 0.7, 1.0],
    );

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: center, radius: radius),
        ),
    );

    final innerGlow = RadialGradient(
      colors: [
        const Color(0xFFD7B46A).withOpacity(0.3),
        const Color(0xFFD7B46A).withOpacity(0.1),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    canvas.drawCircle(
      center,
      radius * 0.5,
      Paint()
        ..shader = innerGlow.createShader(
          Rect.fromCircle(center: center, radius: radius * 0.5),
        ),
    );
  }

  void _drawLantern(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final goldPaint = Paint()..color = const Color(0xFFD7B46A);
    final goldLinePaint = Paint()
      ..color = const Color(0xFFD7B46A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final greenLinePaint = Paint()
      ..color = const Color(0xFF4ADE80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final bodyPaint = Paint()
      ..color = const Color(0xFF141E18)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF3D7A52)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final glassPaint = Paint()
      ..color = const Color(0xFF4ADE80).withOpacity(0.15);

    final flameGradient = RadialGradient(
      colors: [
        const Color(0xFFFFF3E0),
        const Color(0xFFD7B46A).withOpacity(0.8),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    // Hanging chain (top)
    final chainStartY = size.height * 0.08;
    final chainEndY = size.height * 0.22;
    linePaint.color = const Color(0xFF9CA3AF);
    linePaint.strokeWidth = 1.5;
    canvas.drawLine(
      Offset(centerX, chainStartY),
      Offset(centerX, chainEndY),
      linePaint,
    );

    // Small ring at top of chain
    canvas.drawCircle(
      Offset(centerX, chainStartY),
      5,
      Paint()
        ..color = const Color(0xFFD7B46A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // Lantern top cap
    final capTopY = size.height * 0.22;
    final capBottomY = size.height * 0.28;
    final capWidth = size.width * 0.25;

    final capPath = Path()
      ..moveTo(centerX - capWidth * 0.3, capTopY)
      ..lineTo(centerX - capWidth, capBottomY)
      ..lineTo(centerX + capWidth, capBottomY)
      ..lineTo(centerX + capWidth * 0.3, capTopY)
      ..close();
    canvas.drawPath(capPath, goldPaint);

    // Lantern body - octagonal shape
    final bodyTopY = size.height * 0.28;
    final bodyBottomY = size.height * 0.72;
    final bodyWidth = size.width * 0.38;

    final bodyPath = Path()
      ..moveTo(centerX, bodyTopY - bodyWidth * 0.15)
      ..lineTo(centerX + bodyWidth, bodyTopY + bodyWidth * 0.3)
      ..lineTo(centerX + bodyWidth * 0.85, bodyBottomY - bodyWidth * 0.3)
      ..lineTo(centerX, bodyBottomY + bodyWidth * 0.15)
      ..lineTo(centerX - bodyWidth * 0.85, bodyBottomY - bodyWidth * 0.3)
      ..lineTo(centerX - bodyWidth, bodyTopY + bodyWidth * 0.3)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);
    canvas.drawPath(bodyPath, borderPaint);

    // Glass panel highlight
    final glassPath = Path()
      ..moveTo(centerX, bodyTopY - bodyWidth * 0.1)
      ..lineTo(centerX + bodyWidth * 0.85, bodyTopY + bodyWidth * 0.25)
      ..lineTo(centerX + bodyWidth * 0.7, bodyBottomY - bodyWidth * 0.25)
      ..lineTo(centerX, bodyBottomY + bodyWidth * 0.1)
      ..lineTo(centerX - bodyWidth * 0.7, bodyBottomY - bodyWidth * 0.25)
      ..lineTo(centerX - bodyWidth * 0.85, bodyTopY + bodyWidth * 0.25)
      ..close();
    canvas.drawPath(glassPath, glassPaint);

    // Vertical decorative lines on body
    greenLinePaint.strokeWidth = 1;

    canvas.drawLine(
      Offset(centerX, bodyTopY - bodyWidth * 0.12),
      Offset(centerX, bodyBottomY + bodyWidth * 0.12),
      greenLinePaint,
    );

    canvas.drawLine(
      Offset(centerX - bodyWidth * 0.45, bodyTopY + bodyWidth * 0.15),
      Offset(centerX - bodyWidth * 0.42, bodyBottomY - bodyWidth * 0.15),
      greenLinePaint,
    );

    canvas.drawLine(
      Offset(centerX + bodyWidth * 0.45, bodyTopY + bodyWidth * 0.15),
      Offset(centerX + bodyWidth * 0.42, bodyBottomY - bodyWidth * 0.15),
      greenLinePaint,
    );

    // Horizontal decorative bands
    final bandY1 = bodyTopY + (bodyBottomY - bodyTopY) * 0.35;
    final bandY2 = bodyTopY + (bodyBottomY - bodyTopY) * 0.65;

    goldLinePaint.strokeWidth = 1;
    canvas.drawLine(
      Offset(centerX - bodyWidth * 0.82, bandY1),
      Offset(centerX + bodyWidth * 0.82, bandY1),
      goldLinePaint,
    );
    canvas.drawLine(
      Offset(centerX - bodyWidth * 0.82, bandY2),
      Offset(centerX + bodyWidth * 0.82, bandY2),
      goldLinePaint,
    );

    // Lantern bottom cap
    final bottomCapTopY = bodyBottomY;
    final bottomCapBottomY = size.height * 0.78;

    final bottomCapPath = Path()
      ..moveTo(centerX - bodyWidth * 0.85, bottomCapTopY)
      ..lineTo(centerX - bodyWidth * 0.3, bottomCapBottomY)
      ..lineTo(centerX + bodyWidth * 0.3, bottomCapBottomY)
      ..lineTo(centerX + bodyWidth * 0.85, bottomCapTopY)
      ..close();
    canvas.drawPath(bottomCapPath, goldPaint);

    // Bottom finial (pointed end)
    final finialPath = Path()
      ..moveTo(centerX - bodyWidth * 0.3, bottomCapBottomY)
      ..lineTo(centerX, size.height * 0.88)
      ..lineTo(centerX + bodyWidth * 0.3, bottomCapBottomY)
      ..close();
    canvas.drawPath(finialPath, goldPaint);

    // Flame inside lantern
    final flameCenterY = (bodyTopY + bodyBottomY) / 2;
    final flameRadius = bodyWidth * 0.35;

    final flamePaint = Paint()
      ..shader = flameGradient.createShader(
        Rect.fromCircle(
          center: Offset(centerX, flameCenterY),
          radius: flameRadius,
        ),
      );

    canvas.drawCircle(Offset(centerX, flameCenterY), flameRadius, flamePaint);

    // Inner glow ring
    canvas.drawCircle(
      Offset(centerX, flameCenterY),
      flameRadius * 0.5,
      Paint()..color = const Color(0xFFFFF3E0).withOpacity(0.4),
    );

    // Small decorative dots on corners
    final dotPaint = Paint()..color = const Color(0xFF4ADE80);
    final dotPositions = [
      Offset(centerX, bodyTopY - bodyWidth * 0.15),
      Offset(centerX + bodyWidth, bodyTopY + bodyWidth * 0.3),
      Offset(centerX + bodyWidth * 0.85, bodyBottomY - bodyWidth * 0.3),
      Offset(centerX, bodyBottomY + bodyWidth * 0.15),
      Offset(centerX - bodyWidth * 0.85, bodyBottomY - bodyWidth * 0.3),
      Offset(centerX - bodyWidth, bodyTopY + bodyWidth * 0.3),
    ];

    for (final pos in dotPositions) {
      canvas.drawCircle(pos, 2.5, dotPaint);
    }

    // Subtle sparkle effects
    final sparklePaint = Paint()
      ..color = const Color(0xFF4ADE80).withOpacity(0.6);

    final bodyMidY = (bodyTopY + bodyBottomY) / 2;
    final sparkles = [
      Offset(centerX + bodyWidth * 0.5, bodyTopY - 10),
      Offset(centerX - bodyWidth * 0.5, bodyBottomY + 10),
      Offset(centerX + bodyWidth + 15, bodyMidY - 20),
      Offset(centerX - bodyWidth - 15, bodyMidY + 20),
    ];

    for (final sparkle in sparkles) {
      _drawStar(canvas, sparkle, 4, sparklePaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, int points, Paint paint) {
    final path = Path();
    final outerRadius = 4.0;
    final innerRadius = 1.5;

    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * 3.14159 / points) - 3.14159 / 2;
      final x =
          center.dx +
          radius *
              (i == 0
                  ? 0
                  : i == 1
                  ? 0.707
                  : i == 2
                  ? 1
                  : i == 3
                  ? 0.707
                  : i == 4
                  ? 0
                  : i == 5
                  ? -0.707
                  : i == 6
                  ? -1
                  : -0.707);
      final y =
          center.dy +
          radius *
              (i == 0
                  ? -1
                  : i == 1
                  ? -0.707
                  : i == 2
                  ? 0
                  : i == 3
                  ? 0.707
                  : i == 4
                  ? 1
                  : i == 5
                  ? 0.707
                  : i == 6
                  ? 0
                  : -0.707);

      if (i == 0) {
        path.moveTo(center.dx, center.dy - outerRadius);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
