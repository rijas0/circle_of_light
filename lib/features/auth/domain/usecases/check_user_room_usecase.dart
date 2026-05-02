import 'package:circle_of_light/features/auth/domain/repositories/room_repository.dart';

class CheckUserRoomUseCase {
  final RoomRepository repo;

  CheckUserRoomUseCase(this.repo);

  Future<bool> call(String userId) {
    return repo.hasJoinedRoom(userId);
  }
}