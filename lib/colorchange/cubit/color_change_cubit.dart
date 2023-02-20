import 'dart:convert';

import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:distributed_server/colorchange/color_change.dart';
import 'package:distributed_server/connmanager/models/message_model.dart';

JsonEncoder _encoder = const JsonEncoder();
JsonDecoder _decoder = const JsonDecoder();

final _initialState = Message(
  purpose: '_colorchange_',
  clientID: '0',
  data: _encoder.convert(CColor(color: 'white').toJson()),
  connections: '',
);

/// ColorChange Cubit
class ColorChangeCubit extends BroadcastCubit<String> {
  /// Create an instance with an initial state of white color.
  ColorChangeCubit() : super(_encoder.convert(_initialState.toJson()));

  /// Change the current state.
  void changeColor({
    required String newColor,
    required String clientID,
    required Map<int, String> connections,
  }) {
    // Get color to send
    final color =
        CColor.fromJson(_decoder.convert(newColor) as Map<String, dynamic>);
    print(color.toJson());

    final connectionsList = <dynamic>[
      ...connections.entries.map((e) => e.value)
    ];
    // Package message to send
    final message = Message(
      purpose: '_colorchange_',
      data: _encoder.convert(color.toJson()),
      clientID: clientID,
      connections: json.encode(connectionsList),
    );
    emit(_encoder.convert(message.toJson()));
  }
}
