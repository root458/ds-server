import 'package:broadcast_bloc/broadcast_bloc.dart';

/// ConnManager Cubit
class ConnManagerCubit extends BroadcastCubit<int> {
  /// Create an instance with an initial state of 0.
  ConnManagerCubit(int maxConnections) : super(0) {
    _connections = <int, String>{};
    _maxConnections = maxConnections;
  }

  /// Total number of connections possible
  late int _maxConnections;

  /// Storing the current connections
  late Map<int, String> _connections;

  /// Add connection
  void addConnectedClient(String address) {
    if (_connections.containsValue(address)) {
      logCurrentConnections();
      return;
    } else {
      for (var index = 0; index < _maxConnections; index++) {
        if (_connections.containsKey(index)) {
          continue;
        } else {
          // Add connection, abort
          _connections[index] = address;
          logCurrentConnections();
          return;
        }
      }
    }
  }

  /// Remove connection
  void removeConnectedClient(String address) {
    _connections.removeWhere((key, value) => value == address);
    logCurrentConnections();
  }

  /// Upgrade connection
  void upgradeConnection(String address) {
    for (var index = 0; index < _maxConnections; index++) {
      if (_connections.containsKey(index)) {
        continue;
      } else {
        _connections[index] = address;
      }
    }
    logCurrentConnections();
  }

  /// Log current connections
  void logCurrentConnections() {
    print(_connections);
  }

  /// Max Connections reached
  bool maxConnectionsReached() {
    return _connections.length == _maxConnections;
  }
}
