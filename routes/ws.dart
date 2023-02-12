import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:logger/logger.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // A new client has connected to our server.
      Logger().i('connected');

      // Send a message to the client.
      channel.sink.add('hello from the server');

      // Listen for messages from the client.
      channel.stream.listen(
        Logger().i,
        // The client has disconnected.
        onDone: () => Logger().i('disconnected'),
      );
    },
  );

  return handler(context);
}
