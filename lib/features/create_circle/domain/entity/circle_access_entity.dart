import 'package:circle_of_light/features/create_circle/util/focus_enum.dart';

class CircleAccessEntity {
  final String name;
  final String? description;
  final String focus;
  final CirclePrivacy privacy;

  CircleAccessEntity({
    required this.name,
    required this.focus,
    required this.privacy,
    this.description,
  });
}
