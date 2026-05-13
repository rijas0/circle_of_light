import 'package:flutter/material.dart';

// ── Colors ────────────────────────────────────────────────────────────────────
const _bg = Color(0xFF0D1410);
const _card = Color(0xFF141E18);
const _cardBorder = Color(0xFF1E2E22);
const _green = Color(0xFF4ADE80);
const _greenDark = Color(0xFF22C55E);
const _greenDeep = Color(0xFF166534);
const _amber = Color(0xFFD97706);
const _amberBg = Color(0xFFFEF3C7);
const _greenBg = Color(0xFF86EFAC);

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;
  bool _readToday = true;
  bool _reflectedToday = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 20),
                  _buildCheckInCard(),
                  const SizedBox(height: 16),
                  _buildCircleCard(),
                  const SizedBox(height: 20),
                  _buildImpactSection(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Greeting ────────────────────────────────────────────────────────────────

  Widget _buildGreeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Assalamu Alaikum,',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              ),
              const SizedBox(height: 2),
              Row(
                children: const [
                  Text(
                    'Ahmed ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('👋', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Let\'s grow together in the light of the Quran.',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Row(
        //   children: [
        //     // Bell with green dot
        //     Stack(
        //       children: [
        //         Container(
        //           width: 44,
        //           height: 44,
        //           decoration: BoxDecoration(
        //             color: _card,
        //             shape: BoxShape.circle,
        //             border: Border.all(color: _cardBorder, width: 1),
        //           ),
        //           child: const Icon(Icons.notifications_outlined,
        //               color: Colors.white, size: 22),
        //         ),
        //         Positioned(
        //           top: 8,
        //           right: 8,
        //           child: Container(
        //             width: 9,
        //             height: 9,
        //             decoration: BoxDecoration(
        //               color: _greenDark,
        //               shape: BoxShape.circle,
        //               border: Border.all(color: _bg, width: 1.5),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(width: 10),
        //     // Avatar
        //     Container(
        //       width: 44,
        //       height: 44,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         border: Border.all(color: _cardBorder, width: 2),
        //         gradient: const LinearGradient(
        //           colors: [Color(0xFF374151), Color(0xFF1F2937)],
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //         ),
        //       ),
        //       child: ClipOval(
        //         child: Container(
        //           color: const Color(0xFF1F2937),
        //           child: const Icon(Icons.person, color: Color(0xFF9CA3AF), size: 26),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  // ── Today's Check-In Card ───────────────────────────────────────────────────

  Widget _buildCheckInCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Color(0xFF9CA3AF),
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'TODAY\'S CHECK-IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2E22),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'May 12, 2025',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Every day counts. Small steps, big reward.',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Two check-in tiles
          Column(
            children: [
              _buildCheckTile(isRead: true),
              const SizedBox(height: 12),
              _buildCheckTile(isRead: false),
            ],
          ),
          const SizedBox(height: 14),

          // Quote
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1812),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '\u201C\u201C',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 22,
                    height: 0.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"Indeed, this Qur\'an guides to that which is most upright."',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '– Surah Al-Isra (17:9)',
                        style: TextStyle(
                          color: _greenDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckTile({required bool isRead}) {
    final bg = isRead ? const Color.fromARGB(32, 17, 133, 58) : const Color.fromARGB(205, 18, 124, 55);
    final borderColor = isRead ? const Color.fromARGB(204, 17, 133, 58) : const Color(0xFFD4A96A);
    final iconBg = isRead ? const Color(0xFFE8F5EE) : const Color(0xFFFFF8ED);
    final iconColor = isRead ? const Color(0xFF166534) : _amber;
    final label = isRead ? 'I Read Today' : 'I Reflected Today';

    return GestureDetector(
      onTap: () => setState(
        () => isRead
            ? _readToday = !_readToday
            : _reflectedToday = !_reflectedToday,
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRead ? Icons.menu_book_rounded : Icons.edit_note_rounded,
                    color: iconColor,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isRead ? _greenDark : _amber,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ── Your Circle Card ────────────────────────────────────────────────────────

  Widget _buildCircleCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.people_outline,
                    color: Color(0xFF9CA3AF),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'YOUR CIRCLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: const [
                    Text(
                      'View Circle',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF9CA3AF),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Circle info row
          Row(
            children: [
              // Lantern avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _greenDark, width: 2),
                  color: const Color(0xFF0F1812),
                ),
                child: const Center(
                  child: Text('🪔', style: TextStyle(fontSize: 26)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Circle نور',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '5 members',
                      style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Row(
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 4),
                      Text(
                        '12',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Day Streak',
                    style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Today's Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Today's Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '4 / 5 completed',
                style: TextStyle(color: Color(0xFF6B7280), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Member avatars
          Row(
            children: [
              _memberAvatar(emoji: '🧕', done: true),
              const SizedBox(width: 8),
              _memberAvatar(emoji: '🧔', done: true),
              const SizedBox(width: 8),
              _memberAvatar(emoji: '🧑', done: true),
              const SizedBox(width: 8),
              _memberAvatar(emoji: '🌸', done: true),
              const SizedBox(width: 8),
              _memberAvatar(isUnknown: true),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 4 / 5,
              backgroundColor: const Color(0xFF1E2E22),
              valueColor: const AlwaysStoppedAnimation<Color>(_greenDark),
              minHeight: 7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberAvatar({
    String? emoji,
    bool done = false,
    bool isUnknown = false,
  }) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isUnknown ? const Color(0xFF374151) : _greenDark,
          width: isUnknown ? 1.5 : 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        color: const Color(0xFF1A2520),
      ),
      child: Center(
        child: isUnknown
            ? const Icon(
                Icons.question_mark_rounded,
                color: Color(0xFF6B7280),
                size: 20,
              )
            : Text(emoji!, style: const TextStyle(fontSize: 22)),
      ),
    );
  }

  // ── Your Impact ─────────────────────────────────────────────────────────────

  Widget _buildImpactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('✨', style: TextStyle(fontSize: 16)),
            SizedBox(width: 6),
            Text(
              'YOUR IMPACT',
              style: TextStyle(
                color: _greenDark,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _impactTile(
                icon: Icons.menu_book_rounded,
                iconColor: _greenDark,
                value: '23',
                label: 'Verses Read\nThis Week',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _impactTile(
                icon: Icons.edit_note_rounded,
                iconColor: _amber,
                value: '7',
                label: 'Reflections\nThis Week',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _impactTile(
                icon: Icons.people_outline,
                iconColor: const Color(0xFF818CF8),
                value: '18',
                label: 'Total Check-ins\nThis Week',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _impactTile(
                icon: Icons.trending_up_rounded,
                iconColor: _greenDark,
                value: '85%',
                label: 'Consistency\nThis Week',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _impactTile({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 26),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── Bottom Nav ───────────────────────────────────────────────────────────────

  Widget _buildNavBar() {
    final items = [
      _NavItem(Icons.home_rounded, Icons.home_outlined, 'Home'),
      _NavItem(Icons.people_rounded, Icons.people_outline, 'Circle'),
      _NavItem(
        Icons.chat_bubble_rounded,
        Icons.chat_bubble_outline,
        'Reflections',
      ),
      _NavItem(Icons.person_rounded, Icons.person_outline, 'Profile'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0D1410),
        border: Border(top: BorderSide(color: _cardBorder, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              final active = _navIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _navIndex = i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 72,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? item.activeIcon : item.icon,
                        color: active ? _greenDark : const Color(0xFF4B5563),
                        size: 26,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: active ? _greenDark : const Color(0xFF4B5563),
                          fontSize: 11,
                          fontWeight: active
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  const _NavItem(this.activeIcon, this.icon, this.label);
}
