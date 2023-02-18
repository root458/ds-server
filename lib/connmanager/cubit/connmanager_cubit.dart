import 'package:broadcast_bloc/broadcast_bloc.dart';

/// ConnManager Cubit
class ConnManagerCubit extends BroadcastCubit<int> {
  /// Create an instance with an initial state of 0.
  ConnManagerCubit(int maxConnections) : super(0) {
    connections = <int, String>{};
    maxConnections = maxConnections;
  }

  /// Total number of connections possible
  late int maxConnections;

  /// Storing the current connections
  late Map<int, String> connections;

  /// Add connection
  void addConnectedClient(String address) {
    if (connections.containsValue(address)) {
      return;
    } else {
      for (var index = 0; index < maxConnections; index++) {
        if (connections.containsKey(index)) {
          continue;
        } else {
          connections[index] = address;
        }
      }
    }
  }

  /// Remove connection
  void removeConnectedClient(String address) =>
      connections.removeWhere((key, value) => value == address);

  /// Upgrade connection
  void upgradeConnection(String address) {
    for (var index = 0; index < maxConnections; index++) {
      if (connections.containsKey(index)) {
        continue;
      } else {
        connections[index] = address;
      }
    }
  }
}
