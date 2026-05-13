import 'package:circle_of_light/features/create_circle/domain/entity/circle_access_entity.dart';

class CircleAccessModel extends CircleAccessEntity {
  CircleAccessModel({
    required super.name,
    required super.focus,
    required super.privacy,
    super.description,
  });

  factory CircleAccessModel.fromJson(Map<String, dynamic> json) {
    return CircleAccessModel(
      name: json['name'] as String? ?? '',
      focus: json['focus'] as String? ?? '',
      privacy: json['privacy'] as String? ?? (json['isPublic'] == true ? 'Public' : 'Private'),
      description: json['description'] as String? ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description ?? '',
      'focus': focus,
      'privacy': privacy,
    };
  }
}
