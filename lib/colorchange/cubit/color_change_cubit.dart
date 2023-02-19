import 'package:broadcast_bloc/broadcast_bloc.dart';

/// ColorChange Cubit
class ColorChangeCubit extends BroadcastCubit<int> {
  /// Create an instance with an initial state of 0.
  ColorChangeCubit() : super(0);

  /// Increment the current state.
  void increment() => emit(state + 1);

  /// Decrement the current state.
  void decrement() => emit(state - 1);
}
