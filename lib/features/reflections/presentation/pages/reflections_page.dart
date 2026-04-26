import 'package:flutter/material.dart';

import 'package:circle_of_light/features/reflections/data/models/reflection_preview.dart';
import 'package:circle_of_light/features/reflections/presentation/widgets/reflection_card.dart';
import 'package:circle_of_light/shared/widgets/section_title.dart';

class ReflectionsPage extends StatelessWidget {
  const ReflectionsPage({super.key});

  static const _reflections = [
    ReflectionPreview(
      id: 'reflection-1',
      authorName: 'Amina',
      circleName: 'Morning Light',
      verseReference: 'Surah Ad-Duha 93:5',
      message:
          'Today reminded me that hope is part of worship. Even small steps count when they are sincere.',
      reactionCount: 12,
      timeLabel: '2h ago',
    ),
    ReflectionPreview(
      id: 'reflection-2',
      authorName: 'Yusuf',
      circleName: 'Campus Companions',
      verseReference: 'Surah Al-Inshirah 94:6',
      message:
          'Our circle is helping me attach comfort to consistency, not just motivation during special seasons.',
      reactionCount: 9,
      timeLabel: '5h ago',
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
            title: 'Reflection feed',
            subtitle:
                'A quiet feed for insights, encouragement, and shared meaning.',
          ),
          const SizedBox(height: 20),
          for (final reflection in _reflections) ...[
            ReflectionCard(reflection: reflection),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}
