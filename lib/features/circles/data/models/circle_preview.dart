import '../../domain/entities/circle.dart';

class CirclePreview extends Circle {
  const CirclePreview({
    required super.id,
    required super.name,
    required super.memberCount,
    required super.streakDays,
    required super.isPrivate,
    required this.description,
  });

  final String description;
}
