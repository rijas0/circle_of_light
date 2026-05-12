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
      name: json['name'],
      focus: json['focus'],
      privacy: json['privacy'],
      description: json['description'] ?? '',
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
