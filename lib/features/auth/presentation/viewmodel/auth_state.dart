import '../../domain/entities/user_entitie.dart';

class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final bool hasJoinedRoom;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.user,
    this.error,
    this.hasJoinedRoom = false,
  });

  AuthState copyWith({
    bool? isLoading,
    UserEntity? user,
    bool? hasJoinedRoom,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      hasJoinedRoom: hasJoinedRoom ?? this.hasJoinedRoom,
      error: error,
    );
  }
}