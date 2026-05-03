import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildProfileCard(),
              const SizedBox(height: 12),
              _buildStatsRow(),
              const SizedBox(height: 12),
              _buildProgressSection(),
              const SizedBox(height: 12),
              _buildAchievementsSection(),
              const SizedBox(height: 12),
              _buildMenuSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
     // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.settings_outlined,
            color: Colors.white.withOpacity(0.8),
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F2A3F), Color(0xFF0A1628)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Mosque silhouette background
            Positioned(
              right: 0,
              bottom: 0,
              child: CustomPaint(
                size: const Size(200, 140),
                painter: MosquePainter(),
              ),
            ),
            // Stars
            Positioned(
              right: 60,
              top: 18,
              child: Icon(Icons.star, color: Colors.white.withOpacity(0.5), size: 6),
            ),
            Positioned(
              right: 90,
              top: 30,
              child: Icon(Icons.star, color: Colors.white.withOpacity(0.4), size: 5),
            ),
            // Crescent moon
            Positioned(
              right: 30,
              top: 15,
              child: _buildCrescentMoon(),
            ),
            // Profile info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF2ECC71),
                            width: 2.5,
                          ),
                          color: const Color(0xFF2D3E50),
                        ),
                        child: const CircleAvatar(
                          radius: 38,
                          backgroundColor: Color(0xFF2D3E50),
                          child: Icon(Icons.person, color: Colors.white54, size: 40),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: const Color(0xFF152230),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.15),
                            ),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white.withOpacity(0.7),
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ahmed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@ahmed_1998',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A3A2A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFF2ECC71).withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFF2ECC71),
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              'Circle Member',
                              style: TextStyle(
                                color: Color(0xFF2ECC71),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrescentMoon() {
    return SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(painter: CrescentPainter()),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          _buildStatItem('12', 'Circles', true),
          _buildStatDivider(),
          _buildStatItem('87', 'Tasks Completed', true),
          _buildStatDivider(),
          _buildStatItem('45', 'Reflections', true),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, bool expanded) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.45),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 40,
      color: Colors.white.withOpacity(0.08),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'View Details',
                style: TextStyle(
                  color: const Color(0xFF2ECC71),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // This Week
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F2035),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: Colors.white.withOpacity(0.07)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'This Week',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A3A2A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xFF2ECC71),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '18',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' / 25',
                              style: TextStyle(
                                color: Color(0x80FFFFFF),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tasks Completed',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 18 / 25,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF2ECC71)),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Current Streak
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1206),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: const Color(0xFFE67E22).withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Streak',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12,
                            ),
                          ),
                          const Text('🔥', style: TextStyle(fontSize: 22)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '7',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Days',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.7,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFE67E22)),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    final achievements = [
      {
        'icon': Icons.menu_book_rounded,
        'color': const Color(0xFF2ECC71),
        'bg': const Color(0xFF1A3A2A),
        'label': 'Consistent',
        'sub': '7 Days',
      },
      {
        'icon': Icons.groups_rounded,
        'color': const Color(0xFF9B59B6),
        'bg': const Color(0xFF2D1B3D),
        'label': 'Team Player',
        'sub': '10 Circles',
      },
      {
        'icon': Icons.star_rounded,
        'color': const Color(0xFFF39C12),
        'bg': const Color(0xFF3D2A0A),
        'label': 'Dedicated',
        'sub': '50 Tasks',
      },
      {
        'icon': Icons.edit_rounded,
        'color': const Color(0xFF3498DB),
        'bg': const Color(0xFF0F2A3F),
        'label': 'Reflector',
        'sub': '20 Reflections',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: const Color(0xFF2ECC71),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: achievements
                .map((a) => _buildAchievementBadge(a))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(Map<String, dynamic> data) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: data['bg'] as Color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: (data['color'] as Color).withOpacity(0.35), width: 1.5),
          ),
          child: Icon(
            data['icon'] as IconData,
            color: data['color'] as Color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data['label'] as String,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          data['sub'] as String,
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    final items = [
      {'icon': Icons.people_outline_rounded, 'label': 'My Circles', 'trailing': null},
      {'icon': Icons.bookmark_border_rounded, 'label': 'Saved Ayahs', 'trailing': null},
      {'icon': Icons.notifications_none_rounded, 'label': 'Reminders', 'trailing': null},
      {'icon': Icons.dark_mode_outlined, 'label': 'Appearance', 'trailing': 'Dark'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: Colors.white.withOpacity(0.6),
                      size: 20,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        item['label'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (item['trailing'] != null)
                      Text(
                        item['trailing'] as String,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 13,
                        ),
                      ),
                    const SizedBox(width: 6),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white.withOpacity(0.3),
                      size: 20,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.06),
                  indent: 50,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home', 'active': false},
      {'icon': Icons.people_outline, 'label': 'Circles', 'active': false},
      {'icon': Icons.check_box_outlined, 'label': 'Tasks', 'active': false},
      {'icon': Icons.auto_stories_outlined, 'label': 'Reflections', 'active': false},
      {'icon': Icons.person, 'label': 'Profile', 'active': true},
    ];

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF0F1E2D),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.07)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final isActive = item['active'] as bool;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item['icon'] as IconData,
                color: isActive
                    ? const Color(0xFF2ECC71)
                    : Colors.white.withOpacity(0.4),
                size: 22,
              ),
              const SizedBox(height: 4),
              Text(
                item['label'] as String,
                style: TextStyle(
                  color: isActive
                      ? const Color(0xFF2ECC71)
                      : Colors.white.withOpacity(0.4),
                  fontSize: 11,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// Crescent moon painter
class CrescentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF0C040)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.5),
        radius: size.width * 0.45));

    final cutPaint = Paint()
      ..color = const Color(0xFF0A1628)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver;

    canvas.drawPath(path, paint);
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.38),
      size.width * 0.38,
      cutPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Simple mosque silhouette painter
class MosquePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Ground base
    path.moveTo(0, h);
    path.lineTo(w, h);

    // Right tower
    path.lineTo(w, h * 0.35);
    path.lineTo(w - 10, h * 0.25);
    path.lineTo(w - 20, h * 0.35);
    path.lineTo(w - 20, h * 0.55);

    // Center dome
    path.lineTo(w * 0.72, h * 0.55);
    path.lineTo(w * 0.72, h * 0.42);
    final domeRect = Rect.fromCircle(
        center: Offset(w * 0.55, h * 0.42), radius: w * 0.17);
    path.arcTo(domeRect, 0, -3.14159, false);
    path.lineTo(w * 0.38, h * 0.55);

    // Left tower
    path.lineTo(w * 0.2, h * 0.55);
    path.lineTo(w * 0.2, h * 0.35);
    path.lineTo(w * 0.1, h * 0.25);
    path.lineTo(0, h * 0.35);
    path.lineTo(0, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}