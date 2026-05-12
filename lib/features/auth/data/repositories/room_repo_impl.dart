import 'package:dio/dio.dart';

import '../../domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final Dio dio;

  RoomRepositoryImpl(this.dio);

  @override
  Future<bool> hasJoinedRoom(String userId) async {
    return false;
  }
}