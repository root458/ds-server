import 'package:broadcast_bloc/broadcast_bloc.dart';

/// ConnManager Cubit
class ConnManagerCubit extends BroadcastCubit<String> {
  /// Create an instance with an initial state of 0.
  ConnManagerCubit(int maxConnections) : super('') {
    _connections = <int, String>{};
    _maxConnections = maxConnections;
  }

  /// Total number of connections possible
  late int _maxConnections;

  /// Storing the current connections
  late Map<int, String> _connections;

  /// Current connections getter
  Map<int, String> get connections => _connections;

  /// Add connection
  void addConnectedClient(String address) {
    if (_connections.containsValue(address)) {
      logCurrentConnections();
      return;
    } else {
      for (var index = 0; index < _maxConnections; index++) {
        if (_connections.containsKey(index)) {
          if (_connections[index] != '') {
            continue;
          } else {
            // Add connection, abort
            _connections[index] = address;
            logCurrentConnections();
            return;
          }
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
    // _connections.removeWhere((key, value) => value == address);
    final connectionRank = _connections.entries
        .where(
          (element) => element.value == address,
        )
        .first
        .key;
    _connections[connectionRank] = '';
    logCurrentConnections();
  }

  /// Upgrade connection
  void upgradeConnection(String address) {
    for (var index = 0; index < _maxConnections; index++) {
      if (_connections.containsKey(index)) {
        if (_connections[index] != '') {
          continue;
        } else {
          _connections[index] = address;
          logCurrentConnections();
          return;
        }
      } else {
        _connections[index] = address;
        logCurrentConnections();
        return;
      }
    }
  }

  /// Log current connections
  void logCurrentConnections() {
    print(_connections);
  }

  /// Max Connections reached
  bool maxConnectionsReached() {
    return _connections.values.where((element) => element.isNotEmpty).length ==
        _maxConnections;
  }

  /// Get current client ID
  String getCurrentClientID(String address) {
    logCurrentConnections();
    final addr = _connections.entries.where((item) => item.value == address);
    return '${addr.first.key}';
  }
}
