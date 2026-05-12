import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/circle_model.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/progress_badge.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({super.key, required this.circle});

  final CircleModel circle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  circle.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ProgressBadge(
                label: circle.isPublic ? 'Private' : 'Shareable',
                icon: circle.isPublic
                    ? Icons.lock_rounded
                    : Icons.public_rounded,
                backgroundColor: AppColors.mist,
                foregroundColor: AppColors.forest,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            circle.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _InfoPoint(
                icon: Icons.groups_rounded,
                label: '${circle.memberCount} members',
              ),
              const SizedBox(width: 16),
              _InfoPoint(
                icon: Icons.local_fire_department_rounded,
                label: '${circle.streakDays} day streak',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoPoint extends StatelessWidget {
  const _InfoPoint({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.emerald),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
