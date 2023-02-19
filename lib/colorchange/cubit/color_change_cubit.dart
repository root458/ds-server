import 'dart:convert';

import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:distributed_server/colorchange/color_change.dart';

JsonEncoder _encoder = const JsonEncoder();
JsonDecoder _decoder = const JsonDecoder();

/// ColorChange Cubit
class ColorChangeCubit extends BroadcastCubit<String> {
  /// Create an instance with an initial state of white color.
  ColorChangeCubit() : super(_encoder.convert(CColor(color: 'white').toJson()));

  /// Change the current state.
  void changeColor(String newColor) {
    final color =
        CColor.fromJson(_decoder.convert(newColor) as Map<String, dynamic>);
    print(color.toJson());
    emit(_encoder.convert(color.toJson()));
  }
}
