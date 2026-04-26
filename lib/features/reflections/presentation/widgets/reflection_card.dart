import 'package:flutter/material.dart';

import 'package:circle_of_light/core/theme/app_colors.dart';
import 'package:circle_of_light/features/reflections/data/models/reflection_preview.dart';
import 'package:circle_of_light/shared/widgets/app_card.dart';

class ReflectionCard extends StatelessWidget {
  const ReflectionCard({super.key, required this.reflection});

  final ReflectionPreview reflection;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mist,
                foregroundColor: AppColors.forest,
                child: Text(reflection.authorName.characters.first),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reflection.authorName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${reflection.circleName} • ${reflection.timeLabel}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Text(
                reflection.verseReference,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.emerald,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            reflection.message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.favorite_border_rounded,
                size: 18,
                color: AppColors.warning,
              ),
              const SizedBox(width: 8),
              Text(
                '${reflection.reactionCount} reactions',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
