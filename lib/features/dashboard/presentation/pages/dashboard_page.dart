import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/check_in_card.dart';
import '../widgets/metric_tile.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/progress_badge.dart';
import '../../../../shared/widgets/section_title.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "السلام عليكم",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Althaf Ahamed",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.emerald,
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "Let's grow together in the light of Quran.",
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(fontSize: 8.0),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(CircleBorder()),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.emerald,
                      ),
                      iconColor: WidgetStatePropertyAll(AppColors.cream),
                      iconSize: WidgetStatePropertyAll(20.0),
                    ),
                    child: Icon(Icons.notifications_none_rounded),
                  ),

                  CircleAvatar(radius: 24.0, child: Text('AA')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [AppColors.forest, AppColors.emerald],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ProgressBadge(
                  label: 'Circle streak: 12 days',
                  icon: Icons.local_fire_department_rounded,
                  backgroundColor: Color(0x26FFFFFF),
                  foregroundColor: AppColors.white,
                ),
                SizedBox(height: 18),
                Text(
                  'Today\'s intention',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A calm space for daily reading, reflection, and encouragement.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Daily check-in',
            subtitle: 'Keep the habit light, visible, and easy to repeat.',
          ),
          const SizedBox(height: 16),
          const CheckInCard(
            title: 'I read today',
            subtitle:
                'Mark your daily reading and let your circle see the progress.',
            icon: Icons.menu_book_rounded,
            accentColor: AppColors.success,
          ),
          const SizedBox(height: 12),
          const CheckInCard(
            title: 'I reflected today',
            subtitle:
                'Capture one short takeaway that made the reading meaningful.',
            icon: Icons.edit_note_rounded,
            accentColor: AppColors.warning,
          ),
          const SizedBox(height: 28),
          const SectionTitle(
            title: 'Circle pulse',
            subtitle: 'A quick snapshot of how the group is moving together.',
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.25,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: const [
              MetricTile(label: 'Members active', value: '4 / 5'),
              MetricTile(label: 'Shared reflections', value: '18'),
              MetricTile(label: 'Longest streak', value: '27 days'),
              MetricTile(label: 'This week', value: '92%'),
            ],
          ),
          const SizedBox(height: 28),
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why this structure works',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Circle of Light is organized by feature so the app can grow without turning into a shared folder of unrelated screens and services.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
