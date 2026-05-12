import 'package:circle_of_light/features/create_circle/data/model/circle_access_model.dart';

class CircleAccessState {
  final bool isLoading;
  final CircleAccessModel? circle;
  final String? error;

  CircleAccessState({this.isLoading = false, this.circle, this.error});

  CircleAccessState copyWith({bool? isLoading, CircleAccessModel? circle, String? error}) {
    return CircleAccessState(
      isLoading: isLoading ?? this.isLoading,
      circle: circle ?? this.circle,
      error: error,
    );
  }
}
