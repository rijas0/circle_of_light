
class CircleAccessEntity {
  final String name;
  final String? description;
  final String focus;
  final String privacy;

  CircleAccessEntity({
    required this.name,
    required this.focus,
    required this.privacy,
    this.description,
  });
}
