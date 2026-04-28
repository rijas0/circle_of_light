import 'dart:math';
import 'package:circle_of_light/features/circles/presentation/pages/circle_details_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Light Seekers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0A1A0F),
        fontFamily: 'Georgia',
      ),
      home: const CircleDashboard(),
    );
  }
}

class CircleDashboard extends StatefulWidget {
  const CircleDashboard({super.key});

  @override
  State<CircleDashboard> createState() => _CircleDashboardState();
}

class _CircleDashboardState extends State<CircleDashboard> {
  int _selectedNavIndex = 1;

  final List<_Member> members = const [
    _Member('Ahmed', 'Completed', 12, true),
    _Member('Fatima', 'Completed', 9, true),
    _Member('Zaid', 'Pending', 6, false),
    _Member('Yusuf', 'Completed', 11, true),
    _Member('Ali', 'Pending', 5, false),
    _Member('Maryam', 'Pending', 7, false),
  ];

  final List<_Task> tasks = const [
    _Task('Read Surah Yaseen', 5, 8, Icons.menu_book_rounded, Color(0xFF1B4332)),
    _Task('Reflect on Ayah 10', 6, 8, Icons.edit_note_rounded, Color(0xFF1A237E)),
    _Task('Listen to Tafsir', 6, 8, Icons.headphones_rounded, Color(0xFF4E342E)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07120A),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.6),
                radius: 0.8,
                colors: [
                  Color(0xFF0D2B15),
                  Color(0xFF07120A),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopBar(),
                        const SizedBox(height: 16),
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildProgressCard(),
                        const SizedBox(height: 20),
                        _buildTodaysTasks(),
                        const SizedBox(height: 20),
                        _buildMembersSection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom bar + buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF112218),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Circular mosque image
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: CustomPaint(
                painter: _CircleProgressPainter(progress: 1.0, color: const Color(0xFF22C55E)),
              ),
            ),
            ClipOval(
              child: Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1B4332), Color(0xFF0A1A0F)],
                  ),
                ),
                child: const Center(
                  child: Text('🕌', style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Light Seekers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.star, color: Color(0xFF22C55E), size: 20),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          '"And [remember] when hearts were joined\ntogether by Allah\'s favor."',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFB0BEC5),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '(Quran 3:103)',
          style: TextStyle(
            color: Color(0xFF22C55E),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        ElevatedButton(
          onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CircleDetailsScreen())),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 166, 184, 170),
            foregroundColor: Colors.black,
            shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
            side: BorderSide()
          ),
          child: Text('Circle info'))
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1A3322), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Circle Progress',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'View all',
                  style: TextStyle(color: Color(0xFF22C55E), fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CustomPaint(
                  painter: _CircleProgressPainter(
                    progress: 0.72,
                    color: const Color(0xFF22C55E),
                    strokeWidth: 7,
                    showBackground: true,
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '72%',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Overall',
                          style: TextStyle(color: Color(0xFF6B7280), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    _buildStatRow(
                      Icons.book_outlined,
                      'Tasks Completed',
                      '18 / 25',
                      const Color(0xFF1B4332),
                    ),
                    const SizedBox(height: 10),
                    _buildStatRow(
                      Icons.people_outline,
                      'Members Active',
                      '6 / 8',
                      const Color(0xFF1B4332),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value, Color iconBg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1A3322), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(6)),
            child: Icon(icon, color: const Color(0xFF22C55E), size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 12),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaysTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Tasks",
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F1F13),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A3322), width: 1),
          ),
          child: Column(
            children: tasks.asMap().entries.map((entry) {
              final i = entry.key;
              final task = entry.value;
              return Column(
                children: [
                  _buildTaskItem(task),
                  if (i < tasks.length - 1)
                    const Divider(color: Color(0xFF1A3322), height: 1, indent: 16, endIndent: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(_Task task) {
    final progress = task.completed / task.total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: task.iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(task.icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFF1A3322),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF22C55E), width: 2),
                ),
                child: const Icon(Icons.check, color: Color(0xFF22C55E), size: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '${task.completed}/${task.total}',
                style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Members',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'View all',
                style: TextStyle(color: Color(0xFF22C55E), fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...members.map((m) => _buildMemberRow(m)),
      ],
    );
  }

  Widget _buildMemberRow(_Member member) {
    final isCompleted = member.status == 'Completed';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1B4332),
            child: Text(
              member.name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              member.name,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF14532D) : const Color(0xFF3B2A00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              member.status,
              style: TextStyle(
                color: isCompleted ? const Color(0xFF22C55E) : const Color(0xFFF59E0B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              const Text('🔥', style: TextStyle(fontSize: 15)),
              const SizedBox(width: 2),
              Text(
                '${member.streak}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x0007120A), Color(0xFF07120A)],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined, color: Color(0xFF22C55E), size: 18),
                    label: const Text(
                      'Invite Members',
                      style: TextStyle(color: Color(0xFF22C55E), fontSize: 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF22C55E), width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: const Color(0xFF0F1F13),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white, size: 18),
                    label: const Text(
                      'Add Task',
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Nav bar
          // Container(
          //   padding: const EdgeInsets.only(top: 8, bottom: 8),
          //   decoration: const BoxDecoration(
          //     color: Color(0xFF0D1A10),
          //     border: Border(top: BorderSide(color: Color(0xFF1A3322), width: 1)),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       _buildNavItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
          //       _buildNavItem(1, Icons.people_outlined, Icons.people_rounded, 'Circles'),
          //       _buildNavItem(2, Icons.checklist_outlined, Icons.checklist_rounded, 'Tasks'),
          //       _buildNavItem(3, Icons.auto_stories_outlined, Icons.auto_stories_rounded, 'Reflections'),
          //       _buildNavItem(4, Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isActive = _selectedNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedNavIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? const Color(0xFF22C55E) : const Color(0xFF4B5563),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF22C55E) : const Color(0xFF4B5563),
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Data Models ───────────────────────────────────────────────────────────────

class _Member {
  final String name;
  final String status;
  final int streak;
  final bool completed;
  const _Member(this.name, this.status, this.streak, this.completed);
}

class _Task {
  final String name;
  final int completed;
  final int total;
  final IconData icon;
  final Color iconBg;
  const _Task(this.name, this.completed, this.total, this.icon, this.iconBg);
}

// ─── Custom Painter ────────────────────────────────────────────────────────────

class _CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool showBackground;

  const _CircleProgressPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 3.5,
    this.showBackground = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth / 2;

    if (showBackground) {
      final bgPaint = Paint()
        ..color = const Color(0xFF1A3322)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, bgPaint);
    }

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}