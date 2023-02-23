import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/connmanager/connmanager.dart';

// Initialize with max number of connections
final _connManager = ConnManagerCubit(20);

/// Provide the connManager instance via `RequestContext`.
final connManagerProvider = provider<ConnManagerCubit>((_) => _connManager);
