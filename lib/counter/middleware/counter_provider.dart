import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/counter/counter.dart';

final _counter = CounterCubit();

/// Provide the counter instance via `RequestContext`.
final counterProvider = provider<CounterCubit>((_) => _counter);
