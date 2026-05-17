import 'package:circle_of_light/features/get_started/data/model/user_circle_check_model.dart';

class GetStartedState {
  final bool isLoading;
  final UserCircleCheckModel? userCircleStatus;
  final String? error;

  GetStartedState({this.isLoading = false,this.userCircleStatus, this.error});


  GetStartedState copyWith({
    bool? isLoading,
    UserCircleCheckModel? userCircleStatus,
    String? error,
  }) {
    return GetStartedState(
      isLoading: isLoading ?? this.isLoading,
      userCircleStatus: userCircleStatus ?? this.userCircleStatus,
      error: error ?? this.error,
    );
  }
}