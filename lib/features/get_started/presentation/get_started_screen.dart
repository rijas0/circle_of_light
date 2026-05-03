import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo
              _buildLogo(),

              const SizedBox(height: 28),

              // Title
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Dayira ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: 'Circle',
                      style: TextStyle(
                        color: Color(0xFF2ECC71),
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Subtitle
              Text(
                'Grow together. Stay consistent.\nDraw closer to Allah.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 15,
                  height: 1.6,
                  letterSpacing: 0.1,
                ),
              ),

              const SizedBox(height: 28),

              // Page indicator dots
              // _buildPageIndicator(),

              const Spacer(flex: 2),

              // Get started section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Get started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Create a new circle or join an existing one.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Create a Circle card
              _buildActionCard(
                iconWidget: _buildCreateIcon(),
                title: 'Create or Join Circle',
                subtitle: 'Start a new  or join an existing circle and\ninvite your friends.',
                arrowColor: const Color(0xFF2ECC71),
                borderColor: const Color(0xFF2ECC71).withOpacity(0.25),
                backgroundColor: const Color(0xFF0D2018),
                onTap: () => context.push('/create-join-room'),
              ),

              const SizedBox(height: 14),

              // Join a Circle card
              // _buildActionCard(
              //   iconWidget: _buildJoinIcon(),
              //   title: 'Join a Circle',
              //   subtitle: 'Enter an invite code\nto join an existing circle.',
              //   arrowColor: const Color(0xFF3B82F6),
              //   borderColor: const Color(0xFF3B82F6).withOpacity(0.25),
              //   backgroundColor: const Color(0xFF0D1525),
              //   onTap: () {},
              // ),

              const Spacer(flex: 1),

              // Privacy note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.lock_outline_rounded,
                    color: Color(0xFF2ECC71),
                    size: 15,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    'Your data is private and secure',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Home indicator bar
              Center(
                child: Container(
                  width: 130,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 110,
      height: 110,
      child: CustomPaint(
        painter: LogoPainter(),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dot(false),
        const SizedBox(width: 6),
        _dot(true),
        const SizedBox(width: 6),
        _dot(false),
        const SizedBox(width: 6),
        _dot(false),
      ],
    );
  }

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 8 : 6,
      height: active ? 8 : 6,
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF2ECC71)
            : Colors.white.withOpacity(0.25),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildActionCard({
    required Widget iconWidget,
    required String title,
    required String subtitle,
    required Color arrowColor,
    required Color borderColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: arrowColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateIcon() {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFF1A3A2A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.group_add_outlined,
        color: Color(0xFF2ECC71),
        size: 30,
      ),
    );
  }

  Widget _buildJoinIcon() {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2040),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.login_rounded,
        color: Color(0xFF3B82F6),
        size: 30,
      ),
    );
  }
}

// Custom painter for the mosque logo with crescent
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()
      ..color = const Color(0xFF2ECC71)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final greenFill = Paint()
      ..color = const Color(0xFF2ECC71)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.44;

    // Outer arc (almost full circle, open at top-right)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.4,
      // about 290 degrees
      5.6,
      false,
      greenPaint,
    );

    // Crescent moon (top right)
    final moonCenter = Offset(size.width * 0.62, size.height * 0.2);
    final moonPaint = Paint()
      ..color = const Color(0xFF2ECC71)
      ..style = PaintingStyle.fill;
    final moonPath = Path()
      ..addOval(Rect.fromCircle(center: moonCenter, radius: 9));
    canvas.drawPath(moonPath, moonPaint);
    // Cutout for crescent
    final cutPaint = Paint()
      ..color = const Color(0xFF0A0F14)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(moonCenter.dx + 5, moonCenter.dy - 3), 7, cutPaint);

    // Star next to moon
    _drawStar(canvas, Offset(size.width * 0.74, size.height * 0.16), 3, greenFill);

    // Mosque dome
    final domeCenter = Offset(center.dx, size.height * 0.55);
    final domeRadius = size.width * 0.22;

    // Dome (half circle)
    final domePath = Path();
    domePath.moveTo(domeCenter.dx - domeRadius, domeCenter.dy);
    domePath.arcTo(
      Rect.fromCircle(center: domeCenter, radius: domeRadius),
      3.14159,
      -3.14159,
      false,
    );
    domePath.lineTo(domeCenter.dx + domeRadius, domeCenter.dy);
    domePath.close();
    canvas.drawPath(domePath, greenFill);

    // Minaret/spire on top
    final spireRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: Offset(center.dx, domeCenter.dy - domeRadius - 10),
          width: 10,
          height: 20),
      const Radius.circular(5),
    );
    canvas.drawRRect(spireRect, greenFill);

    // Mosque body below dome
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, size.height * 0.72),
        width: size.width * 0.38,
        height: size.height * 0.22,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(bodyRect, greenFill);

    // Door arch
    final doorCutPaint = Paint()
      ..color = const Color(0xFF0A0F14)
      ..style = PaintingStyle.fill;
    final doorPath = Path();
    final doorCenter = Offset(center.dx, size.height * 0.76);
    doorPath.moveTo(doorCenter.dx - 8, size.height * 0.84);
    doorPath.lineTo(doorCenter.dx - 8, doorCenter.dy);
    doorPath.arcTo(
      Rect.fromCircle(center: doorCenter, radius: 8),
      3.14159,
      -3.14159,
      false,
    );
    doorPath.lineTo(doorCenter.dx + 8, size.height * 0.84);
    doorPath.close();
    canvas.drawPath(doorPath, doorCutPaint);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * 3.14159) / 5 - 3.14159 / 2;
      final x = center.dx + radius * _cos(angle);
      final y = center.dy + radius * _sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  double _cos(double angle) => _cosApprox(angle);
  double _sin(double angle) => _sinApprox(angle);

  double _cosApprox(double x) {
    // Simple Taylor series approximation for small angles
    return 1 - x * x / 2 + x * x * x * x / 24;
  }

  double _sinApprox(double x) {
    return x - x * x * x / 6 + x * x * x * x * x / 120;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}