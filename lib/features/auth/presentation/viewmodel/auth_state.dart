import '../../domain/entities/user_entitie.dart';

class AuthState {
  final bool isLoading;
  final bool isInitializing;
  final UserEntity? user;
  final bool hasJoinedRoom;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isInitializing = true,
    this.user,
    this.error,
    this.hasJoinedRoom = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isInitializing,
    UserEntity? user,
    bool? hasJoinedRoom,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isInitializing: isInitializing ?? this.isInitializing,
      user: user ?? this.user,
      hasJoinedRoom: hasJoinedRoom ?? this.hasJoinedRoom,
      error: error,
    );
  }
}