import 'package:flutter/material.dart';

import 'package:circle_of_light/core/theme/app_colors.dart';
import 'package:circle_of_light/shared/widgets/app_card.dart';
import 'package:circle_of_light/shared/widgets/progress_badge.dart';
import 'package:circle_of_light/shared/widgets/section_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionTitle(
            title: 'Profile',
            subtitle:
                'A lightweight summary of your consistency and circle presence.',
          ),
          SizedBox(height: 20),
          AppCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.emerald,
                  foregroundColor: AppColors.white,
                  child: Text(
                    'A',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Akhil',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Building a steady Quran rhythm with two active circles.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          AppCard(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ProgressBadge(
                  label: '24 total check-ins',
                  icon: Icons.check_circle_outline_rounded,
                  backgroundColor: AppColors.mist,
                  foregroundColor: AppColors.forest,
                ),
                ProgressBadge(
                  label: '12-day streak',
                  icon: Icons.local_fire_department_rounded,
                  backgroundColor: AppColors.mist,
                  foregroundColor: AppColors.forest,
                ),
                ProgressBadge(
                  label: '7 reflections shared',
                  icon: Icons.auto_stories_rounded,
                  backgroundColor: AppColors.mist,
                  foregroundColor: AppColors.forest,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suggested next modules',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Auth, realtime services, and persistent repositories can drop into each feature folder without changing the overall project shape.',
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
