import 'package:circle_of_light/features/circles/data/models/circle_list_model.dart';

class CircleState {
  final bool isLoading;
  final List<CircleListModel> circles;
  final String? error;

  CircleState({this.isLoading = false, this.circles = const [], this.error});

  CircleState copyWith({
    bool? isLoading,
    List<CircleListModel>? circles,
    String? error,
  }) {
    return CircleState(
      isLoading: isLoading ?? this.isLoading,
      circles: circles ?? this.circles,
      error: error ?? this.error,
    );
  }
}