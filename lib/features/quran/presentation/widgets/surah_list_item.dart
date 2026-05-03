import 'package:flutter/material.dart';

import '../../domain/entities/surah.dart';

class SurahListItem extends StatelessWidget {
  const SurahListItem({super.key, required this.surah, this.onTap});

  final Surah surah;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF141E18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF1E2E22), width: 1),
        ),
        child: Row(
          children: [
            _buildNumberBadge(),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    surah.englishName,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${surah.verseCount} verses • ${surah.revelationType == RevelationType.makki ? "Makki" : "Madani"}',
                    style: const TextStyle(
                      color: Color(0xFF4ADE80),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              surah.arabicName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Noto Sans Arabic',
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right, color: Color(0xFF4ADE80), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberBadge() {
    return SizedBox(
      width: 42,
      height: 42,
      child: Center(
        child: CustomPaint(
          size: const Size(40, 40),
          painter: _OctagonPainter(
            color: const Color(0xFF1E2E22),
            borderColor: const Color(0xFF4ADE80),
          ),
          child: Center(
            child: Text(
              '${surah.number}',
              style: const TextStyle(
                color: Color(0xFF4ADE80),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OctagonPainter extends CustomPainter {
  final Color color;
  final Color borderColor;

  _OctagonPainter({required this.color, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    for (var i = 0; i < 8; i++) {
      final angle = (i * 45 - 22.5) * 3.14159 / 180;
      final x = center.dx + radius * (i == 0 ? 0.7 : i == 1 ? 0.707 : i == 2 ? 0 : i == 3 ? -0.707 : i == 4 ? -0.7 : i == 5 ? -0.707 : i == 6 ? 0 : 0.707);
      final y = center.dy + radius * (i == 0 ? -1 : i == 1 ? -0.707 : i == 2 ? 0.7 : i == 3 ? 0.707 : i == 4 ? 1 : i == 5 ? 0.707 : i == 6 ? -0.7 : -0.707);
      if (i == 0) {
        path.moveTo(center.dx + radius * 0, center.dy - radius * 1);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final fillPaint = Paint()..color = color;
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
