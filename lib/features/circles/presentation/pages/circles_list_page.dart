import 'package:flutter/material.dart';

import 'package:circle_of_light/core/theme/app_colors.dart';
import 'package:circle_of_light/features/circles/data/models/circle_preview.dart';
import 'package:circle_of_light/features/circles/presentation/widgets/circle_card.dart';
import 'package:circle_of_light/shared/widgets/section_title.dart';

class CirclesPage extends StatelessWidget {
  const CirclesPage({super.key});

  static const _circles = [
    CirclePreview(
      id: 'circle-1',
      name: 'Morning Light',
      memberCount: 5,
      streakDays: 12,
      isPrivate: true,
      description:
          'A close-knit circle for short morning recitation and check-ins.',
    ),
    CirclePreview(
      id: 'circle-2',
      name: 'Family Reflection',
      memberCount: 4,
      streakDays: 8,
      isPrivate: true,
      description: 'A family rhythm focused on consistency after Ramadan.',
    ),
    CirclePreview(
      id: 'circle-3',
      name: 'Campus Companions',
      memberCount: 5,
      streakDays: 17,
      isPrivate: false,
      description:
          'A student-led space for accountability, reminders, and support.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Your circles',
            subtitle: 'Small private groups where consistency becomes visible.',
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            label: const Text('Create a circle'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.emerald,
              foregroundColor: AppColors.white,
            ),
          ),
          const SizedBox(height: 20),
          for (final circle in _circles) ...[
            CircleCard(circle: circle),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
