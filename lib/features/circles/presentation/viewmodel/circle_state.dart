import 'package:circle_of_light/features/circles/data/models/circle_model.dart';

class CircleState {
  final bool isLoading;
  final CircleModel? circle;
  final String? error;

  CircleState({this.isLoading = false, this.circle, this.error});

  CircleState copyWith({bool? isLoading, CircleModel? circle, String? error}) {
    return CircleState(
      isLoading: isLoading ?? this.isLoading,
      circle: circle ?? this.circle,
      error: error ?? this.error,
    );
  }
}