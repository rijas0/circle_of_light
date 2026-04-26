class ReflectionEntry {
  const ReflectionEntry({
    required this.id,
    required this.authorName,
    required this.circleName,
    required this.verseReference,
    required this.message,
    required this.reactionCount,
  });

  final String id;
  final String authorName;
  final String circleName;
  final String verseReference;
  final String message;
  final int reactionCount;
}
