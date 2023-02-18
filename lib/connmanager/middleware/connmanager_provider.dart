import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/connmanager/connmanager.dart';

final _connManager = ConnManagerCubit();

/// Provide the connManager instance via `RequestContext`.
final connManagerProvider = provider<ConnManagerCubit>((_) => _connManager);
