import '../../domain/entities/reflection_entry.dart';

class ReflectionPreview extends ReflectionEntry {
  const ReflectionPreview({
    required super.id,
    required super.authorName,
    required super.circleName,
    required super.verseReference,
    required super.message,
    required super.reactionCount,
    required this.timeLabel,
  });

  final String timeLabel;
}
