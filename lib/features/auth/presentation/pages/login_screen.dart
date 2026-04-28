import 'dart:math';
import 'package:circle_of_light/app/app_shell.dart';
import 'package:circle_of_light/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle of Light',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A1A0F),
      ),
      home: const LoginScreen(),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AnimationController _animController;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;
  late TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = ()=>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SignUpScreen()));
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _tapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF07120A),
      body: Stack(
        children: [
          // ── Hero background (top half) ──────────────────────────────────
          SizedBox(
            height: size.height * 0.52,
            width: double.infinity,
            child: CustomPaint(
              painter: _NightSkyPainter(),
            ),
          ),

          // ── Moon ───────────────────────────────────────────────────────
          Positioned(
            top: 60,
            left: 36,
            child: _buildMoon(),
          ),

          // ── Stars ──────────────────────────────────────────────────────
          Positioned.fill(
            child: CustomPaint(painter: _StarsPainter()),
          ),

          // ── Mosque silhouette ──────────────────────────────────────────
          Positioned(
            bottom: size.height * 0.46,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(size.width, 160),
              painter: _MosqueSilhouettePainter(),
            ),
          ),

          // ── Lanterns (left & right) ────────────────────────────────────
          Positioned(
            left: 10,
            top: size.height * 0.24,
            child: _buildLantern(size: 52),
          ),
          Positioned(
            right: 10,
            top: size.height * 0.22,
            child: _buildLantern(size: 56),
          ),

          // ── Logo + Title ───────────────────────────────────────────────
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                _buildLogo(),
                const SizedBox(height: 14),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Circle of ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                      ),
                      TextSpan(
                        text: 'Light',
                        style: TextStyle(
                          color: Color(0xFF4ADE80),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Read. Reflect. Rise Together.',
                  style: TextStyle(
                    color: Color(0xFFB0BEC5),
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom sheet ───────────────────────────────────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: _buildBottomSheet(size),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Logo widget ────────────────────────────────────────────────────────────

  Widget _buildLogo() {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(painter: _LogoPainter()),
    );
  }

  // ── Moon ───────────────────────────────────────────────────────────────────

  Widget _buildMoon() {
    return CustomPaint(
      size: const Size(44, 44),
      painter: _MoonPainter(),
    );
  }

  // ── Lantern ────────────────────────────────────────────────────────────────

  Widget _buildLantern({required double size}) {
    return CustomPaint(
      size: Size(size, size * 1.5),
      painter: _LanternPainter(),
    );
  }

  // ── Bottom sheet ───────────────────────────────────────────────────────────

  Widget _buildBottomSheet(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0E1B12),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome back',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Log in to continue your journey',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
          const SizedBox(height: 24),

          // Email field
          _buildTextField(
            controller: _emailController,
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),

          // Password field
          _buildTextField(
            controller: _passwordController,
            hint: 'Password',
            icon: Icons.lock_outline_rounded,
            obscure: _obscurePassword,
            suffix: GestureDetector(
              onTap: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
              child: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF6B7280),
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Forgot password
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                  color: Color(0xFF22C55E),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Log In button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AppShell())),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4ADE80),
                foregroundColor: const Color(0xFF052e16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: const Text(
                'Log In',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Divider
          Row(
            children: [
              Expanded(
                  child: Divider(
                      color: Colors.white.withOpacity(0.12), thickness: 1)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'or continue with',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                ),
              ),
              Expanded(
                  child: Divider(
                      color: Colors.white.withOpacity(0.12), thickness: 1)),
            ],
          ),
          const SizedBox(height: 16),

          // Social buttons
          Row(
            children: [
              Expanded(child: _buildSocialButton(isGoogle: true)),
              const SizedBox(width: 12),
              Expanded(child: _buildSocialButton(isGoogle: false)),
            ],
          ),
          const SizedBox(height: 22),

          // Sign up
          RichText(
            text:  TextSpan(
              children: [
                TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                ),
                TextSpan(
                  text: 'Sign up',
                  style: TextStyle(
                    color: Color(0xFF22C55E),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: _tapRecognizer
                )
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Home indicator bar
          Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A1A0F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1A3322), width: 1.2),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF4B5563), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
          suffixIcon: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required bool isGoogle}) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF1A3322), width: 1.2),
        backgroundColor: const Color(0xFF0A1A0F),
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isGoogle)
            CustomPaint(size: const Size(18, 18), painter: _GoogleIconPainter())
          else
            const Icon(Icons.apple, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            isGoogle ? 'Google' : 'Apple',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Custom Painters
// ══════════════════════════════════════════════════════════════════════════════

class _NightSkyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Sky gradient
    final skyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF040E08),
          Color(0xFF071A0C),
          Color(0xFF0D2818),
          Color(0xFF081510),
        ],
        stops: [0.0, 0.4, 0.75, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, skyPaint);

    // Mountain silhouettes
    final mountainPaint = Paint()..color = const Color(0xFF071008);
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.55);
    path.quadraticBezierTo(
        size.width * 0.15, size.height * 0.28, size.width * 0.3, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.42, size.height * 0.32, size.width * 0.5, size.height * 0.42);
    path.quadraticBezierTo(
        size.width * 0.6, size.height * 0.28, size.width * 0.7, size.height * 0.48);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.3, size.width, size.height * 0.52);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, mountainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _StarsPainter extends CustomPainter {
  static final List<Offset> _positions = List.generate(
    38,
    (i) => Offset(
      (i * 137.508 % 390),
      (i * 97.3 % 260),
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.55);
    for (final pos in _positions) {
      final r = (pos.dx % 1.6) + 0.6;
      canvas.drawCircle(pos, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFD4C87A);
    // Crescent: draw full circle then subtract
    final path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.5, size.height * 0.5),
          radius: size.width * 0.48));
    final cutPath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width * 0.72, size.height * 0.38),
          radius: size.width * 0.44));
    final crescent =
        Path.combine(PathOperation.difference, path, cutPath);
    canvas.drawPath(crescent, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Green crescent arc
    final arcPaint = Paint()
      ..color = const Color(0xFF4ADE80)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: size.width * 0.42),
      pi * 1.1,
      pi * 1.4,
      false,
      arcPaint,
    );

    // Lantern body
    final lanternPaint = Paint()..color = const Color(0xFFD4A017);
    final lw = size.width * 0.18;
    final lh = size.height * 0.32;
    final lx = cx - lw / 2;
    final ly = cy - lh * 0.5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(lx, ly, lw, lh), const Radius.circular(4)),
      lanternPaint,
    );

    // Glow
    final glowPaint = Paint()
      ..color = const Color(0xFFD4A017).withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(Offset(cx, cy + lh * 0.1), lw * 1.4, glowPaint);

    // Lantern lines
    final linePaint = Paint()
      ..color = const Color(0xFF7A5C00)
      ..strokeWidth = 1;
    for (int i = 1; i < 3; i++) {
      final y = ly + lh * (i / 3.0);
      canvas.drawLine(Offset(lx, y), Offset(lx + lw, y), linePaint);
    }

    // Hanging chain
    final chainPaint = Paint()
      ..color = const Color(0xFF4ADE80)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(cx, cy - size.height * 0.46), Offset(cx, ly), chainPaint);

    // Leaf decorations
    _drawLeaf(canvas, Offset(cx + size.width * 0.32, cy + size.height * 0.2),
        const Color(0xFF4ADE80), size.width * 0.1, 0.4);
    _drawLeaf(canvas, Offset(cx - size.width * 0.36, cy + size.height * 0.22),
        const Color(0xFF4ADE80), size.width * 0.1, pi - 0.4);
  }

  void _drawLeaf(Canvas canvas, Offset pos, Color color, double r, double angle) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(pos.dx, pos.dy);
    path.quadraticBezierTo(
      pos.dx + cos(angle) * r * 1.2,
      pos.dy + sin(angle) * r * 0.5,
      pos.dx + cos(angle) * r * 2,
      pos.dy,
    );
    path.quadraticBezierTo(
      pos.dx + cos(angle) * r * 1.2,
      pos.dy - sin(angle) * r * 0.5,
      pos.dx,
      pos.dy,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _MosqueSilhouettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF060F08);
    final w = size.width;
    final h = size.height;
    final path = Path();

    // Ground
    path.moveTo(0, h);
    path.lineTo(0, h * 0.65);

    // Left minaret
    path.lineTo(w * 0.12, h * 0.65);
    path.lineTo(w * 0.12, h * 0.2);
    path.lineTo(w * 0.14, h * 0.15);
    path.lineTo(w * 0.16, h * 0.2);
    path.lineTo(w * 0.16, h * 0.65);

    // Left side
    path.lineTo(w * 0.28, h * 0.65);
    path.lineTo(w * 0.28, h * 0.5);
    path.quadraticBezierTo(w * 0.3, h * 0.35, w * 0.32, h * 0.5);
    path.lineTo(w * 0.32, h * 0.65);

    // Left small minaret
    path.lineTo(w * 0.38, h * 0.65);
    path.lineTo(w * 0.38, h * 0.3);
    path.lineTo(w * 0.4, h * 0.22);
    path.lineTo(w * 0.42, h * 0.3);
    path.lineTo(w * 0.42, h * 0.65);

    // Main dome
    path.lineTo(w * 0.44, h * 0.65);
    path.lineTo(w * 0.44, h * 0.45);
    final domeRect = Rect.fromLTWH(w * 0.36, h * 0.05, w * 0.28, h * 0.42);
    path.arcTo(domeRect, pi, -pi, false);
    path.lineTo(w * 0.56, h * 0.65);

    // Right small minaret
    path.lineTo(w * 0.58, h * 0.65);
    path.lineTo(w * 0.58, h * 0.3);
    path.lineTo(w * 0.6, h * 0.22);
    path.lineTo(w * 0.62, h * 0.3);
    path.lineTo(w * 0.62, h * 0.65);

    // Right side
    path.lineTo(w * 0.68, h * 0.65);
    path.lineTo(w * 0.68, h * 0.5);
    path.quadraticBezierTo(w * 0.7, h * 0.35, w * 0.72, h * 0.5);
    path.lineTo(w * 0.72, h * 0.65);

    // Right minaret
    path.lineTo(w * 0.84, h * 0.65);
    path.lineTo(w * 0.84, h * 0.2);
    path.lineTo(w * 0.86, h * 0.15);
    path.lineTo(w * 0.88, h * 0.2);
    path.lineTo(w * 0.88, h * 0.65);

    path.lineTo(w, h * 0.65);
    path.lineTo(w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _LanternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Glow
    final glowPaint = Paint()
      ..color = const Color(0xFFD4A017).withOpacity(0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(w / 2, h * 0.6), width: w * 2, height: h * 0.8),
        glowPaint);

    // Chain
    final chainPaint = Paint()
      ..color = const Color(0xFF8B7536)
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(w / 2, 0), Offset(w / 2, h * 0.12), chainPaint);

    // Body
    final bodyPaint = Paint()..color = const Color(0xFF8B7536);
    final bodyRect =
        RRect.fromRectAndRadius(Rect.fromLTWH(w * 0.15, h * 0.12, w * 0.7, h * 0.72), const Radius.circular(4));
    canvas.drawRRect(bodyRect, bodyPaint);

    // Inner glow
    final innerPaint = Paint()..color = const Color(0xFFD4A017).withOpacity(0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.22, h * 0.18, w * 0.56, h * 0.58),
          const Radius.circular(3)),
      innerPaint,
    );

    // Lines
    final linePaint = Paint()
      ..color = const Color(0xFF5A4A1A)
      ..strokeWidth = 1;
    for (int i = 1; i < 4; i++) {
      final y = h * 0.12 + (h * 0.72) * (i / 4.0);
      canvas.drawLine(Offset(w * 0.15, y), Offset(w * 0.85, y), linePaint);
    }

    // Bottom cap
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.25, h * 0.84, w * 0.5, h * 0.1),
          const Radius.circular(3)),
      bodyPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;

    void drawArcSegment(Color color, double start, double sweep) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.width * 0.28
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.72),
          start,
          sweep,
          false,
          paint);
    }

    drawArcSegment(const Color(0xFF4285F4), -0.52, pi * 0.98);
    drawArcSegment(const Color(0xFF34A853), pi * 0.46, pi * 0.52);
    drawArcSegment(const Color(0xFFFBBC05), pi * 0.98, pi * 0.52);
    drawArcSegment(const Color(0xFFEA4335), pi * 1.5, pi * 0.46);

    // White horizontal bar for the "G" cut
    final barPaint = Paint()
      ..color = const Color(0xFF0A1A0F)
      ..strokeWidth = size.width * 0.28;
    canvas.drawLine(
        Offset(cx, cy), Offset(cx + r * 0.95, cy), barPaint);

    // Dot in center
    canvas.drawCircle(
        Offset(cx, cy), r * 0.18, Paint()..color = const Color(0xFF4285F4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}