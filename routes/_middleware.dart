import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/colorchange/color_change.dart';
import 'package:distributed_server/connmanager/connmanager.dart';
import 'package:distributed_server/counter/counter.dart';

Handler middleware(Handler handler) {
  return handler
      .use(counterProvider)
      .use(connManagerProvider)
      .use(colorChangeProvider);
}
