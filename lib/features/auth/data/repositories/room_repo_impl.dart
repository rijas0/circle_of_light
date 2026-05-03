import 'package:dio/dio.dart';

import '../../domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final Dio dio;

  RoomRepositoryImpl(this.dio);

  @override
  Future<bool> hasJoinedRoom(String userId) async {
    // Mocking to avoid Dio errors since no BaseUrl is set
    // final res = await dio.get('/user/$userId/room');
    // return res.data['hasRoom'] == true;
    return false;
  }
}