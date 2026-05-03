import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/provider.dart';
import '../viewmodel/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);

    _slideAnim = Tween<double>(
      begin: 30,
      end: 0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }
      if (previous?.user == null && next.user != null && mounted) {
        context.go('/');
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background radial glow
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF2ECC71).withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Animated logo
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: AnimatedBuilder(
                      animation: _pulseAnim,
                      builder: (context, child) => Transform.scale(
                        scale: _pulseAnim.value,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: CustomPaint(painter: LogoPainter()),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value),
                        child: child,
                      ),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Quran ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                          TextSpan(
                            text: 'Circle',
                            style: TextStyle(
                              color: Color(0xFF2ECC71),
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value * 1.3),
                        child: child,
                      ),
                    ),
                    child: Text(
                      'Grow together. Stay consistent.\nDraw closer to Allah.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16,
                        height: 1.65,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Page dots
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) =>
                        Opacity(opacity: _fadeAnim.value, child: child),
                    child: _buildPageIndicator(),
                  ),

                  const Spacer(flex: 3),

                  // Feature highlights
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value * 1.6),
                        child: child,
                      ),
                    ),
                    child: _buildFeatureHighlights(),
                  ),

                  const Spacer(flex: 2),

                  // Connect button
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) => Opacity(
                      opacity: _fadeAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, _slideAnim.value * 2),
                        child: child,
                      ),
                    ),
                    child: _buildConnectButton(),
                  ),

                  const SizedBox(height: 16),

                  // Terms note
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) =>
                        Opacity(opacity: _fadeAnim.value, child: child),
                    child: Text(
                      'By continuing, you agree to our Terms & Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.25),
                        fontSize: 11,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Privacy badge
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) =>
                        Opacity(opacity: _fadeAnim.value, child: child),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFF2ECC71),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Your data is private and secure',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.38),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Home indicator
                  Center(
                    child: Container(
                      width: 130,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) {
        final isActive = i == 0;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Container(
            width: isActive ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF2ECC71)
                  : Colors.white.withOpacity(0.22),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFeatureHighlights() {
    final features = [
      {
        'icon': Icons.groups_rounded,
        'color': const Color(0xFF2ECC71),
        'bg': const Color(0xFF0D2018),
        'border': const Color(0xFF2ECC71),
        'title': 'Study in Circles',
        'sub': 'Learn with your community',
      },
      {
        'icon': Icons.local_fire_department_rounded,
        'color': const Color(0xFFF39C12),
        'bg': const Color(0xFF1E1206),
        'border': const Color(0xFFF39C12),
        'title': 'Build Streaks',
        'sub': 'Stay consistent daily',
      },
      {
        'icon': Icons.auto_stories_outlined,
        'color': const Color(0xFF3B82F6),
        'bg': const Color(0xFF0D1525),
        'border': const Color(0xFF3B82F6),
        'title': 'Share Reflections',
        'sub': 'Grow in knowledge',
      },
    ];

    return Row(
      children: features.map((f) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: f['bg'] as Color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (f['border'] as Color).withOpacity(0.2),
                  width: 1.2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: (f['color'] as Color).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      f['icon'] as IconData,
                      color: f['color'] as Color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    f['title'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    f['sub'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.38),
                      fontSize: 10,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConnectButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2ECC71).withOpacity(0.30),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () async {
            await ref.read(authNotifierProvider.notifier).loginWithQuran();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.link_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'Connect with Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mosque + crescent logo painter
class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final green = const Color(0xFF2ECC71);
    final bg = const Color(0xFF0A0F14);

    final strokePaint = Paint()
      ..color = green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = green
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.44;

    // Outer arc — almost full circle, gap at top-right
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      0.5,
      5.5,
      false,
      strokePaint,
    );

    // Crescent moon
    final moonCx = cx + r * math.cos(-0.5);
    final moonCy = cy + r * math.sin(-0.5) - 4;
    final moonR = 9.0;

    canvas.drawCircle(Offset(moonCx, moonCy), moonR, fillPaint);
    canvas.drawCircle(
      Offset(moonCx + 5.5, moonCy - 3),
      moonR * 0.76,
      Paint()..color = bg,
    );

    // Star
    _drawStar(
      canvas,
      Offset(moonCx + moonR * 1.6, moonCy - moonR * 0.6),
      3.5,
      fillPaint,
    );

    // Minaret spire
    final spireTop = cy - size.height * 0.28;
    final spireRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, spireTop + 10), width: 8, height: 22),
      const Radius.circular(4),
    );
    canvas.drawRRect(spireRect, fillPaint);

    // Dome
    final domeCenter = Offset(cx, cy - size.height * 0.06);
    final domeRadius = size.width * 0.21;
    final domePath = Path()
      ..moveTo(domeCenter.dx - domeRadius, domeCenter.dy)
      ..arcTo(
        Rect.fromCircle(center: domeCenter, radius: domeRadius),
        math.pi,
        -math.pi,
        false,
      )
      ..lineTo(domeCenter.dx + domeRadius, domeCenter.dy)
      ..close();
    canvas.drawPath(domePath, fillPaint);

    // Body
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(cx, cy + size.height * 0.18),
        width: size.width * 0.36,
        height: size.height * 0.24,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(bodyRect, fillPaint);

    // Door arch cutout
    final doorCx = cx;
    final doorBottomY = cy + size.height * 0.30;
    final doorArcCenter = Offset(doorCx, doorBottomY - 14);
    final doorPath = Path()
      ..moveTo(doorCx - 7, doorBottomY)
      ..lineTo(doorCx - 7, doorArcCenter.dy)
      ..arcTo(
        Rect.fromCircle(center: doorArcCenter, radius: 7),
        math.pi,
        -math.pi,
        false,
      )
      ..lineTo(doorCx + 7, doorBottomY)
      ..close();
    canvas.drawPath(doorPath, Paint()..color = bg);
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * math.pi) / 5 - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
