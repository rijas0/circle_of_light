import 'dart:developer';

import '../../domain/entity/user_circle_check_entity.dart';

class UserCircleCheckModel extends UserCircleCheckEntity {
  UserCircleCheckModel({
    required super.success,
    required super.circleCount,
    required super.isNewUser,
  });

  factory UserCircleCheckModel.fromJSON(Map<String, dynamic> json) {
    return UserCircleCheckModel(
      success: json['success'],
      circleCount: json['circleCount'],
      isNewUser: json['isNewUser'],
    );
  }
}
