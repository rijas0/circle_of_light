import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/circle_model.dart';
import '../widgets/circle_card.dart';
import '../../../../shared/widgets/section_title.dart';

class CirclesScreen extends StatelessWidget {
  const CirclesScreen({super.key});

  static const _circles = [
    CircleModel(
      id: 'circle-1',
      name: 'Morning Light',
      memberCount: 5,
      streakDays: 12,
      isPublic: true,
      description:
          'A close-knit circle for short morning recitation and check-ins.',
      inviteId: 222,
      creatorId: 111,
      focus: '',
    ),
    CircleModel(
      id: 'circle-2',
      name: 'Family Reflection',
      memberCount: 4,
      streakDays: 8,

      description: 'A family rhythm focused on consistency after Ramadan.',
      isPublic: false,
      inviteId: 333,
      creatorId: 333,
      focus: '',
    ),
    CircleModel(
      id: 'circle-3',
      name: 'Campus Companions',
      memberCount: 5,
      streakDays: 17,
      description:
          'A student-led space for accountability, reminders, and support.',
      isPublic: false,
      inviteId: 2233,
      creatorId: 222,
      focus: '',
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
