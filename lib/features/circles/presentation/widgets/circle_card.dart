import 'dart:developer';

import 'package:circle_of_light/features/circles/data/models/circle_list_model.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_card.dart';

class CircleCard extends StatelessWidget {
  const CircleCard({super.key, required this.circle,required this.onTap});

  final CircleListModel circle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle icon
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A3520),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF2A6640), width: 2),
                ),
                child: const Center(
                  child: Text('🕌', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 12),
              // Name + description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      circle.circleName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFFE8F5E9),
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      circle.circleDescription ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.45),
                        height: 1.45,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Privacy badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      circle.isPublic ? Icons.public_rounded : Icons.lock_rounded,
                      size: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      circle.isPublic ? 'Public' : 'Private',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: Color(0x0DFFFFFF)),
          Row(
            children: [
              const Icon(Icons.people_rounded, size: 14, color: Color(0xFF22C55E)),
              const SizedBox(width: 4),
              Text(
                '${circle.memberCount} members',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              const Spacer(),
              _StackedAvatars(members: []),
            ],
          ),
        ],
      ),
    );
  }
}
class _StackedAvatars extends StatelessWidget {
  const _StackedAvatars({required this.members});

  /// Each entry: (initials, bgColor, fgColor)
  final List<({String initials, Color bg, Color fg})> members;

  static const _overlap = 6.0;
  static const _size = 22.0;

  @override
  Widget build(BuildContext context) {
    final visible = members.take(3).toList();
    final overflow = members.length - visible.length;
    final items = [...visible];

    return SizedBox(
      height: _size,
      width: visible.length * (_size - _overlap) + _size + (overflow > 0 ? _size - _overlap : 0),
      child: Stack(
        children: [
          for (int i = 0; i < items.length; i++)
            Positioned(
              left: i * (_size - _overlap),
              child: _AvatarCircle(
                label: items[i].initials,
                bg: items[i].bg,
                fg: items[i].fg,
              ),
            ),
          if (overflow > 0)
            Positioned(
              left: items.length * (_size - _overlap),
              child: _AvatarCircle(
                label: '+$overflow',
                bg: const Color(0xFF1E2F1E),
                fg: const Color(0xFF86EFAC),
                fontSize: 7,
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({
    required this.label,
    required this.bg,
    required this.fg,
    this.fontSize = 8,
  });
  final String label;
  final Color bg, fg;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF122110), width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}