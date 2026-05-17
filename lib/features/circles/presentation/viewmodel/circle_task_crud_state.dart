class CircleTaskCrudState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> response;

  CircleTaskCrudState({this.isLoading = false,this.error,this.response = const {} });

  CircleTaskCrudState copyWith({
    bool? isLoading,
    Map<String, dynamic>? response ,
    String? error,
  }) {
    return CircleTaskCrudState(
      isLoading: isLoading ?? this.isLoading,
      response: response ?? this.response,
      error: error ?? this.error,
    );
  }
}