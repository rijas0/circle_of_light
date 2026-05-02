import 'package:circle_of_light/features/auth/domain/repositories/room_repository.dart';
import 'package:dio/dio.dart';

class RoomRepositoryImpl implements RoomRepository {
  final Dio dio;

  RoomRepositoryImpl(this.dio);

  @override
  Future<bool> hasJoinedRoom(String userId) async {
    final res = await dio.get('/user/$userId/room');
    return res.data['hasRoom'] == true;
  }
}