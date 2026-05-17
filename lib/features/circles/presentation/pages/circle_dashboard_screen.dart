
import 'dart:developer';
import 'dart:math' hide log;

import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/circles/data/models/circle_details_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_member_model.dart';
import 'package:circle_of_light/features/circles/domain/entities/circle_task_entity.dart';
import 'package:circle_of_light/features/circles/presentation/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/add_task.dart';

class CircleDashboard extends ConsumerStatefulWidget {
  const CircleDashboard({super.key, required this.circleId});

  final String circleId;

  @override
  ConsumerState<CircleDashboard> createState() => _CircleDashboardState();
}

class _CircleDashboardState extends ConsumerState<CircleDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref
          .read(circleDetailsNotifierProvider.notifier)
          .fetchCircleDetails(circleId: widget.circleId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(circleDetailsNotifierProvider);
    final details = vm.circleDetails;
    final userId = details?.userId ?? '0';
    final creatorId = details?.creatorId;
    final isUserAdmin = userId == creatorId;

    if (vm.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (vm.error != null) {

      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  vm.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => ref
                      .read(circleDetailsNotifierProvider.notifier)
                      .fetchCircleDetails(circleId: widget.circleId),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }


    if (details == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.6),
                radius: 0.8,
                colors: [Color(0xFF0D2B15), Color(0xFF07120A)],
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
                        _buildHeader(details),
                        const SizedBox(height: 20),
                        _buildProgressCard(details),
                        const SizedBox(height: 20),
                        _buildTodaysTasks(details),
                        const SizedBox(height: 20),
                        _buildMembersSection(details),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isUserAdmin ?? false ?
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: _buildBottomSection(),
            ):SizedBox(),
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
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
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
              child: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(CircleDetailsModel circleDetails) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: CustomPaint(
                painter: _CircleProgressPainter(
                  progress: 1.0,
                  color: const Color(0xFF22C55E),
                ),
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
                  child: Text('\u{1F54C}', style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              circleDetails.circleName,
              style: const TextStyle(
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
        Text(
          circleDetails.circleDescription ?? 'Circle Description',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFB0BEC5), fontSize: 13, height: 1.5),
        ),
        const SizedBox(height: 4),
        Text(
          '${circleDetails.memberCount} Member${circleDetails.memberCount > 1 ? 's' : ''} active',
          style: const TextStyle(
            color: Color(0xFF22C55E),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(CircleDetailsModel circleDetails) {
    final metrics = circleDetails.circleMetrics;
    final progress = metrics.overallPercentage / 100.0;

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
          const Text(
            'Circle Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CustomPaint(
                  painter: _CircleProgressPainter(
                    progress: progress.clamp(0.0, 1.0),
                    color: const Color(0xFF22C55E),
                    strokeWidth: 7,
                    showBackground: true,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${metrics.overallPercentage}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
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
                      '${metrics.completedTaskCount} / ${metrics.totalTaskCount}',
                    ),
                    const SizedBox(height: 10),
                    _buildStatRow(
                      Icons.people_outline,
                      'Completed Members',
                      '${metrics.completedMembersCount} / ${metrics.totalMembersCount}',
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

  Widget _buildStatRow(IconData icon, String label, String value) {
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
            decoration: BoxDecoration(
              color: const Color(0xFF1B4332),
              borderRadius: BorderRadius.circular(6),
            ),
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

  Widget _buildTodaysTasks(CircleDetailsModel circleDetails) {
    final taskList = circleDetails.taskList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Today's Tasks",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F1F13),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1A3322), width: 1),
          ),
          child: taskList.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.info, color: Colors.white54),
                      SizedBox(width: 10),
                      Text('No Task for today',
                          style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                )
              : Column(
                  children: taskList.asMap().entries.map((entry) {
                    final i = entry.key;
                    final task = entry.value;
                    return Column(
                      children: [
                        _buildTaskItem(task),
                        if (i < taskList.length - 1)
                          const Divider(
                            color: Color(0xFF1A3322),
                            height: 1,
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(CircleTaskEntity task) {
    final completed = task.completedTask ?? 0;
    final total = task.totalTaskCount ?? 1;
    final progress = (completed / total).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFF1B4332),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
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
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF22C55E),
                    ),
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
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF22C55E),
                  size: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$completed/$total',
                style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection(CircleDetailsModel circleDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: const Text(
            //     'View all',
            //     style: TextStyle(color: Color(0xFF22C55E), fontSize: 13),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 12),
        if (circleDetails.membersList.isNotEmpty)
          ...circleDetails.membersList.map((m) => _buildMemberRow(m,circleDetails.userId??'',circleDetails.taskList.isEmpty?false:true)),
      ],
    );
  }

  Widget _buildMemberRow(CircleMemberModel member,String userId,bool hasTasks) {
    final isCompleted = member.completionStatus == 'Completed';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1B4332),
            child: Text(
              member.memberName.isNotEmpty ? member.memberName[0] : '?',
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
              member.memberId == userId ? 'You': member.memberName.isNotEmpty ? member.memberName : 'Unknown',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          hasTasks ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF14532D)
                  : const Color(0xFF3B2A00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              member.completionStatus.isNotEmpty ? member.completionStatus : 'No Status',
              style: TextStyle(
                color: isCompleted
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFF59E0B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ):SizedBox(),
          const SizedBox(width: 10),
          Row(
            children: [
              const Text('\u{1F525}', style: TextStyle(fontSize: 15)),
              const SizedBox(width: 2),
              Text(
                '${member.streakCount}',
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
    return Padding(
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
              onPressed: (){
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const AddTaskSheet(),
                  );
              },
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
    );
  }


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
