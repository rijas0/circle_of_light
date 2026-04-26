class Circle {
  const Circle({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.streakDays,
    required this.isPrivate,
  });

  final String id;
  final String name;
  final int memberCount;
  final int streakDays;
  final bool isPrivate;
}
