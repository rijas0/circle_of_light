import 'package:circle_of_light/features/circles/data/models/circle_details_model.dart';

class CircleDetailsState {
  final bool isLoading;
  final CircleDetailsModel? circleDetails;
  final String? error;

  CircleDetailsState({this.isLoading = false, this.circleDetails, this.error});

  CircleDetailsState copyWith({
    bool? isLoading,
    CircleDetailsModel? circleDetails,
    String? error,
  }) {
    return CircleDetailsState(
      isLoading: isLoading ?? this.isLoading,
      circleDetails: circleDetails ?? this.circleDetails,
      error: error ?? this.error,
    );
  }
}