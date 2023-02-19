import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:distributed_server/connmanager/connmanager.dart';
import 'package:distributed_server/counter/counter.dart';

Future<Response> onRequest(RequestContext context) async {
  // Initialize conn manager
  final connManagerCubit = context.read<ConnManagerCubit>();
  final handler = webSocketHandler(
    (channel, protocol) {
      // Accept no more connections
      if (connManagerCubit.maxConnectionsReached()) {
        return;
      }
      // Log address
      final address = context.request.connectionInfo.remoteAddress;
      connManagerCubit.addConnectedClient(address.address);
      // A new client has connected to our server.
      // Subscribe the new client to receive notifications
      // whenever the cubit state changes.
      final counterCubit = context.read<CounterCubit>()..subscribe(channel);

      // Send the current count to the new client.
      channel.sink.add('${counterCubit.state}');

      // Listen for messages from the client.
      channel.stream.listen(
        (event) {
          switch (event) {
            // Handle an increment message.
            case '__increment__':
              counterCubit.increment();
              break;
            // Handle a decrement message.
            case '__decrement__':
              counterCubit.decrement();
              break;
            // Ignore any other messages.
            default:
              break;
          }
        },
        // The client has disconnected.
        // Unsubscribe the channel.
        onDone: () {
          counterCubit.unsubscribe(channel);
          connManagerCubit.removeConnectedClient(address.address);
        },
      );
    },
  );

  return handler(context);
}
