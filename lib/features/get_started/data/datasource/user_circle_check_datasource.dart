import '../../../../core/storage/token_storage_service.dart';
import '../model/user_circle_check_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/api/app_api.dart';

class UserCircleStatus {
  final Dio dio;
  final TokenStorageService tokenService;
  UserCircleStatus(this.dio, this.tokenService);

  Future<UserCircleCheckModel> checkUserHasCircle() async {
    try {
      final token = tokenService.getAccessToken();
      final response = await dio.get(
        checkUserHasCircles,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      return UserCircleCheckModel.fromJSON(response.data);
    } catch (e) {
      throw Exception("Failed to Check user circle Details circle: $e");
    }
  }
}
