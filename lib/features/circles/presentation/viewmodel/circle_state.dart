import 'package:circle_of_light/features/circles/data/models/circle_model.dart';

class CircleState {
  final bool isLoading;
  final List<CircleModel> circles;
  final String? error;

  CircleState({this.isLoading = false, this.circles = const [], this.error});

  CircleState copyWith({
    bool? isLoading,
    List<CircleModel>? circles,
    String? error,
  }) {
    return CircleState(
      isLoading: isLoading ?? this.isLoading,
      circles: circles ?? this.circles,
      error: error ?? this.error,
    );
  }
}