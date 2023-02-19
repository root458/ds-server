import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:distributed_server/colorchange/color_change.dart';

/// ColorChange Cubit
class ColorChangeCubit extends BroadcastCubit<CColor> {
  /// Create an instance with an initial state of white color.
  ColorChangeCubit() : super(CColor(color: 'white'));

  /// Change the current state.
  void changeColor(CColor color) => emit(color);
}
