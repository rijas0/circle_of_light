import 'package:circle_of_light/features/circles/data/models/circle_progress_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/circle_model.dart';
import '../widgets/circle_card.dart';
import '../../../../shared/widgets/section_title.dart';

class CirclesScreen extends StatelessWidget {
  const CirclesScreen({super.key});

  static List circles = [
    CircleModel(
      circleId: 'circle-1',
      circleName: 'Morning Light',
      memberCount: 5,
      isPublic: true,
      circleDescription:
          'A close-knit circle for short morning recitation and check-ins.',
      inviteId: 222,
      creatorId: 111,
      focus: '', 
      circleProgress: CircleProgressModel(completedMembersCount: '', completedTaskCount: '', overallPercentage: '', totalTaskCount: ''),
       membersList: [], 
       completedMembers: '4',
       taskList: [],
    ),
    CircleModel(
      circleId: 'circle-2',
      circleName: 'Family Reflection',
      memberCount: 4,

      circleDescription: 'A family rhythm focused on consistency after Ramadan.',
      isPublic: false,
      inviteId: 333,
      creatorId: 333,
      focus: '',
      taskList: [],
      membersList: [],
      completedMembers: '4',
      circleProgress: CircleProgressModel(completedMembersCount: '', completedTaskCount:'', overallPercentage: '', totalTaskCount:'')
    ),
    CircleModel(
      circleId: 'circle-3',
      circleName: 'Campus Companions',
      memberCount: 5,
      circleDescription:
          'A student-led space for accountability, reminders, and support.',
      isPublic: false,
      inviteId: 2233,
      creatorId: 222,
      membersList: [],
      focus: '',
      taskList: [],
      completedMembers: '4',
      circleProgress: CircleProgressModel(completedMembersCount: '', completedTaskCount:'', overallPercentage:'', totalTaskCount:'')
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
          for (final circle in circles) ...[
            CircleCard(circle: circle),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
