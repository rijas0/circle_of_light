import '../../domain/usecases/circle_usecase.dart';
import 'circle_state.dart';
import 'package:riverpod/legacy.dart';

class CircleNotifier extends StateNotifier<CircleState>{
  final CircleUseCase circleUseCase;

  CircleNotifier(this.circleUseCase):super(CircleState());

  Future<void> getCircleDetails({required String accessToken})async{
    state = state.copyWith(isLoading: true);
    try{
      final circleDetails = await circleUseCase(accessToken: accessToken);
      state = state.copyWith(isLoading: false,circle: circleDetails);
    }catch(e){
      state = state.copyWith(isLoading: false,error: e.toString());
    }
  }
}