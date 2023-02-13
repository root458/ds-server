import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/counter/counter.dart';

Handler middleware(Handler handler) => handler.use(counterProvider);
