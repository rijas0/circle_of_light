import 'dart:ffi';

import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';
import 'package:circle_of_light/features/dashboard/presentation/provider/provider.dart';
import 'package:circle_of_light/features/dashboard/presentation/viewmodel/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Colors ────────────────────────────────────────────────────────────────────
const _bg = Color(0xFF0D1410);
const _card = Color(0xFF141E18);
const _cardBorder = Color(0xFF1E2E22);
const _green = Color(0xFF4ADE80);
const _greenDark = Color(0xFF22C55E);
const _greenDeep = Color(0xFF166534);
const _amber = Color(0xFFD97706);

// ── Data Model ────────────────────────────────────────────────────────────────

// class CircleMember {
//   final String emoji;
//   final bool completedToday;
//   const CircleMember({required this.emoji, this.completedToday = false});
// }

// class QuranCircle {
//   final String id;
//   final String name;
//   final String emoji;
//   final int streak;
//   final List<CircleMember> members;
//   bool readToday;
//   bool reflectedToday;
//   bool isExpanded;

//   QuranCircle({
//     required this.id,
//     required this.name,
//     required this.emoji,
//     required this.streak,
//     required this.members,
//     this.readToday = false,
//     this.reflectedToday = false,
//     this.isExpanded = false,
//   });

//   int get completedMembers => members.where((m) => m.completedToday).length;
//   bool get isFullyDone => readToday && reflectedToday;
// }

// ── Screen ────────────────────────────────────────────────────────────────────

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _navIndex = 0;
  int completedCircleCount = 3;
  int taskDoneToday = 3;
  int circlePending = 4;
  bool isExpanded = false;
  bool readToday = false;
  bool reflectedToday = false;

  // final List<QuranCircle> _circles = [
  //   QuranCircle(
  //     id: '1',
  //     name: 'Circle نور',
  //     emoji: '🪔',
  //     streak: 12,
  //     readToday: true,
  //     reflectedToday: true,
  //     isExpanded: true,
  //     members: const [
  //       CircleMember(emoji: '🧕', completedToday: true),
  //       CircleMember(emoji: '🧔', completedToday: true),
  //       CircleMember(emoji: '🧑', completedToday: true),
  //       CircleMember(emoji: '🌸', completedToday: true),
  //       CircleMember(emoji: ''),
  //     ],
  //   ),
  //   QuranCircle(
  //     id: '2',
  //     name: 'Circle Badr',
  //     emoji: '🌙',
  //     streak: 7,
  //     readToday: true,
  //     reflectedToday: true,
  //     members: const [
  //       CircleMember(emoji: '🌿', completedToday: true),
  //       CircleMember(emoji: '⭐', completedToday: true),
  //       CircleMember(emoji: '🦋', completedToday: true),
  //       CircleMember(emoji: '🕊️', completedToday: true),
  //     ],
  //   ),
  //   QuranCircle(
  //     id: '3',
  //     name: 'Circle Safa',
  //     emoji: '🌿',
  //     streak: 3,
  //     members: const [
  //       CircleMember(emoji: '🌺', completedToday: true),
  //       CircleMember(emoji: ''),
  //       CircleMember(emoji: ''),
  //     ],
  //   ),
  // ];

  // ── Computed ─────────────────────────────────────────────────────────────

  // int get _circlesDone => _circles.where((c) => c.isFullyDone).length;
  // int get _tasksDone => _circles.fold(
  //       0,
  //       (sum, c) => sum + (c.readToday ? 1 : 0) + (c.reflectedToday ? 1 : 0),
  //     );
  // int get _pendingCircles => _circles.length - _circlesDone;

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    //ref.read(homeNotifierProvider.notifier).getHomeDetails();
    final vm = ref.read(homeNotifierProvider);
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: vm.isLoading
                  ? Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Loading please wait'),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      children: [
                        _buildGreeting( vm.home),
                        const SizedBox(height: 20),
                        _buildCheckInSummaryCard(vm.home),
                        const SizedBox(height: 16),
                        _buildCirclesSection(vm.home),
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

  // ── Greeting ───────────────────────────────────────────────────────────────

  Widget _buildGreeting(HomeModel? hm) {
    
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
                children:  [
                  Text(
                    hm?.userName ?? "مؤمن"  ,
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
      ],
    );
  }

  // ── Today's Check-In Summary Card ─────────────────────────────────────────

  Widget _buildCheckInSummaryCard(HomeModel? hm) {
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
                child:  Text(
                  DateTime.now().toString(), //TODO:Change this to proper date format
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Your progress across all circles today.',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Summary stat tiles
          Row(
            children: [
              Expanded(
                child: _summaryStatTile(
                  // value: '$_circlesDone/${_circles.length}',
                  value: '${completedCircleCount.toString()}/4',
                  label: 'Circles\ncompleted',
                  valueColor: _greenDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryStatTile(
                  // value: '$_tasksDone',
                  value: taskDoneToday.toString(),
                  label: 'Tasks done\ntoday',
                  valueColor: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _summaryStatTile(
                  // value: '$_pendingCircles',
                  value: circlePending.toString(),
                  label: 'Circles\npending',
                  valueColor: 4 > 0 ? _amber : _greenDark,
                ),
              ),
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
              children:  [
                Text(
                  '\u201C\u201C',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 22,
                    height: 0.8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hm?.dailyQuote ?? 'Random Quote', //TODO: Add some default quote
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        hm?.dailyQuote ?? '-Surah', //TODO: Add surah name 
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

  Widget _summaryStatTile({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1812),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
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

  // ── Circles Section ────────────────────────────────────────────────────────

  Widget _buildCirclesSection(HomeModel? hm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.people_outline, color: Color(0xFF9CA3AF), size: 18),
                SizedBox(width: 8),
                Text(
                  'YOUR CIRCLES',
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
                    'Manage',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 18),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Circle accordion rows
        ...hm!.circleList.map((circles)=>_buildCircleAccordion(circles)),
       // ..._circles.map((circle) => _buildCircleAccordion(circle)),
      ],
    );
  }

  Widget _buildCircleAccordion(CircleModel circle) {
    final completedMembers = int.parse(circle.completedMembers);
    final isFullyDone =
        completedMembers == circle.memberCount;
    final completionColor = isFullyDone
        ? _greenDark
        : !isFullyDone //TODO:FIX THIS 
        ? _amber
        : const Color(0xFF6B7280);


    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded ? _greenDark : _cardBorder,
          //color: _cardBorder,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // ── Collapsed summary row ──
            GestureDetector(
              onTap: () =>
                  setState(() => isExpanded = !isExpanded),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(13),
                child: Row(
                  children: [
                    // Emoji avatar
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isExpanded
                              ? _greenDark
                              : const Color(0xFF374151),
                          width: 2,
                        ),
                        color: const Color(0xFF0F1812),
                      ),
                      child: Center(
                        child: Text(
                          // circle.emoji,
                          'Emoji',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name + member count
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            circle.circleName ,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${circle.memberCount} members',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Streak badge
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFF1A2010),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       const Text('🔥', style: TextStyle(fontSize: 13)),
                    //       const SizedBox(width: 3),
                    //       Text(
                    //         '${circle.}',
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(width: 8),
                    // Completion pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: completionColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${circle.completedMembers}/${circle.memberCount} done',
                        style: TextStyle(
                          color: completionColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Chevron
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF4B5563),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Expanded body ──
            if (isExpanded) ...[
              Container(height: 1, color: _cardBorder),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Check-in tiles
                    _buildCheckTile(
                      isRead: true,
                     // isChecked: circle.readToday,
                     isChecked: readToday,
                      onTap: () =>
                          setState(() => readToday = !readToday),
                    ),
                    const SizedBox(height: 10),
                    _buildCheckTile(
                      isRead: false,
                      isChecked: reflectedToday,
                      onTap: () => setState(
                        () => reflectedToday = !reflectedToday,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Today's progress label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today's Progress",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${circle.completedMembers} / ${circle.memberCount} members',
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Member avatars
                    // Row(
                    //   children: circle.memberCount
                    //       .map(
                    //         (m) => Padding(
                    //           padding: const EdgeInsets.only(right: 8),
                    //           child: _memberAvatar(
                    //             emoji: m.emoji,
                    //             done: m.completedToday,
                    //             isUnknown: m.emoji.isEmpty,
                    //           ),
                    //         ),
                    //       )
                    //       .toList(),
                    // ),
                    const SizedBox(height: 12),

                    // Progress bar
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(6),
                    //   child: LinearProgressIndicator(
                    //     value: circle.members.isEmpty
                    //         ? 0
                    //         : circle.completedMembers / circle.members.length,
                    //     backgroundColor: const Color(0xFF1E2E22),
                    //     valueColor: AlwaysStoppedAnimation<Color>(
                    //       isFullyDone ? _greenDark : _amber,
                    //     ),
                    //     minHeight: 7,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCheckTile({
    required bool isRead,
    required bool isChecked,
    required VoidCallback onTap,
  }) {
    final bg = isRead
        ? const Color.fromARGB(32, 17, 133, 58)
        : const Color.fromARGB(30, 217, 119, 6);
    final borderColor = isRead
        ? const Color.fromARGB(204, 17, 133, 58)
        : const Color(0xFFD4A96A);
    final iconBg = isRead ? const Color(0xFFE8F5EE) : const Color(0xFFFFF8ED);
    final iconColor = isRead ? const Color(0xFF166534) : _amber;
    final checkColor = isRead ? _greenDark : _amber;
    final label = isRead ? 'I Read Today' : 'I Reflected Today';

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isChecked ? bg : const Color(0xFF0F1812),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isChecked ? borderColor : const Color(0xFF2A3830),
          ),
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
                    color: isChecked ? iconBg : const Color(0xFF1A2520),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRead ? Icons.menu_book_rounded : Icons.edit_note_rounded,
                    color: isChecked ? iconColor : const Color(0xFF4B5563),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isChecked ? Colors.white : const Color(0xFF6B7280),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isChecked ? checkColor : Colors.transparent,
                shape: BoxShape.circle,
                border: isChecked
                    ? null
                    : Border.all(color: const Color(0xFF374151), width: 2),
              ),
              child: isChecked
                  ? const Icon(Icons.check, color: Colors.white, size: 13)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _memberAvatar({
    String? emoji,
    bool done = false,
    bool isUnknown = false,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isUnknown
              ? const Color(0xFF374151)
              : done
              ? _greenDark
              : const Color(0xFF374151),
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
                size: 18,
              )
            : Text(emoji!, style: const TextStyle(fontSize: 20)),
      ),
    );
  }

  // ── Your Impact ────────────────────────────────────────────────────────────

  Widget _buildImpactSection() {
    // Aggregate across all circles
    final totalVerses = 23;
    // final totalReflections = _circles.fold(
    //   0,
    //   (sum, c) => sum + (c.reflectedToday ? 1 : 0),
    // );
    // final totalCheckins = _circles.fold(
    //   0,
    //   (sum, c) => sum + (c.readToday ? 1 : 0) + (c.reflectedToday ? 1 : 0),
    // );
    // final consistencyPct = ((_circlesDone / _circles.length) * 100).round();

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
                value: '$totalVerses',
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
                // value: '$consistencyPct%',
                value: '',
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

  // ── Bottom Nav ─────────────────────────────────────────────────────────────

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
