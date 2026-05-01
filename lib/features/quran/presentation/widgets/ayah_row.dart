import 'package:flutter/material.dart';

import '../../domain/entities/ayah.dart';

class AyahRow extends StatelessWidget {
  const AyahRow({super.key, required this.ayah, this.isFirst = false, this.isLast = false});

  final Ayah ayah;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVerseNumber(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    ayah.arabicText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 2.2,
                      fontFamily: 'Noto Sans Arabic',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ayah.englishTranslation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          const Divider(
            color: Color(0xFF1E2E22),
            height: 32,
          ),
      ],
    );
  }

  Widget _buildVerseNumber() {
    return SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: CustomPaint(
          size: const Size(28, 28),
          painter: _SmallOctagonPainter(),
          child: Center(
            child: Text(
              '${ayah.number}',
              style: const TextStyle(
                color: Color(0xFF4ADE80),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SmallOctagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1;

    final paint = Paint()
      ..color = const Color(0xFF1E2E22)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF4ADE80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    const angles = [-90.0, -45.0, 0.0, 45.0, 90.0, 135.0, 180.0, 225.0];
    for (var i = 0; i < angles.length; i++) {
      final angle = angles[i] * 3.14159 / 180;
      final x = center.dx + radius * 0.7 * (i == 0 ? 0 : i == 1 ? 0.707 : i == 2 ? 1 : i == 3 ? 0.707 : i == 4 ? 0 : i == 5 ? -0.707 : i == 6 ? -1 : -0.707);
      final y = center.dy + radius * 0.7 * (i == 0 ? -1 : i == 1 ? -0.707 : i == 2 ? 0 : i == 3 ? 0.707 : i == 4 ? 1 : i == 5 ? 0.707 : i == 6 ? 0 : -0.707);
      if (i == 0) {
        path.moveTo(center.dx, center.dy - radius * 0.7);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
