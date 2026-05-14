import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';
import '../widgets/circle_card.dart';
import '../../data/models/circle_model.dart';
import '../../../../shared/widgets/section_title.dart';

class CirclesScreen extends ConsumerStatefulWidget {
  const CirclesScreen({super.key});

  @override
  ConsumerState<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends ConsumerState<CirclesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(circleListProvider.notifier).getCircleDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(circleListProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Your Circles',
            subtitle: 'Small private groups where consistency becomes visible.',
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.add_rounded,
                  label: 'Create Circle',
                  color: const Color(0xFF2ECC71),
                  bgColor: const Color(0xFF1A3A2A),
                  borderColor: const Color(0xFF2ECC71),
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  icon: Icons.login_rounded,
                  label: 'Join Circle',
                  color: const Color(0xFF3B82F6),
                  bgColor: const Color(0xFF0D1525),
                  borderColor: const Color(0xFF3B82F6),
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (state.isLoading && state.circles.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48),
              child: Center(child: CircularProgressIndicator()),
            ),

          if (state.error != null && state.circles.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      state.error!,
                      style: TextStyle(color: Colors.red[400], fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: () => ref.read(circleListProvider.notifier).getCircleDetails(),
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),

          if (state.circles.isNotEmpty) ...[
            _SummaryStrip(circles: state.circles),
            const SizedBox(height: 20),
          ],

          if (!state.isLoading && state.circles.isEmpty && state.error == null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Text(
                  'No circles yet. Create or join one to get started!',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          for (final circle in state.circles) ...[
            CircleCard(circle: circle),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color bgColor;
  final Color borderColor;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.bgColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor.withOpacity(0.35), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryStrip extends StatelessWidget {
  final List<CircleModel> circles;

  const _SummaryStrip({required this.circles});

  @override
  Widget build(BuildContext context) {
    final totalTasks = circles.fold<int>(0, (sum, c) => sum + (c.taskList?.length ?? 0));
    final totalMembers = circles.fold<int>(0, (sum, c) => sum + (c.memberCount ?? 0));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          _strip(circles.length.toString(), 'Active Circles', const Color(0xFF2ECC71)),
          _divider(),
          _strip(totalTasks.toString(), 'Tasks Total', const Color(0xFFF39C12)),
          _divider(),
          _strip(totalMembers.toString(), 'Members', const Color(0xFF9B59B6)),
        ],
      ),
    );
  }

  Widget _strip(String val, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(val,
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.38), fontSize: 10)),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1, height: 32,
        color: Colors.white.withOpacity(0.07),
      );
}
