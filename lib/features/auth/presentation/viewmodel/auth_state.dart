import '../../domain/entities/user_entitie.dart';

class AuthState {
  final bool isLoading;
  final UserEntity? user;

  AuthState({this.isLoading = false, this.user});
}