import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';

class HomeState {
  final bool isLoading;
  final HomeModel? home;
  final String? error;

  HomeState({this.isLoading = false, this.home, this.error});

  HomeState copyWith({bool? isLoading, HomeModel? home, String? error}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      home: home ?? this.home,
      error: error ?? this.error,
    );
  }
}
