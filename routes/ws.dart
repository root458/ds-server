import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:distributed_server/colorchange/color_change.dart';
import 'package:distributed_server/connmanager/connmanager.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // Initialize connection manager
      final connManagerCubit = context.read<ConnManagerCubit>()
        ..subscribe(channel);
      // Accept no more connections
      if (connManagerCubit.maxConnectionsReached()) {
        return;
      }
      // Log client ID
      final uniqueID = context.request.uri.queryParameters['id']!;
      connManagerCubit.addConnectedClient(uniqueID);
      // A new client has connected to our server.
      // Subscribe the new client to receive notifications
      // whenever the cubit state changes.
      final colorChangeCubit = context.read<ColorChangeCubit>()
        ..subscribe(channel);

      // Send the current color to the new client.
      channel.sink.add(colorChangeCubit.state);

      // Send upgrade chances.
      channel.sink.add(connManagerCubit.state);

      // Listen for messages from the client.
      channel.stream.listen(
        (newReq) {
          final req = newReq as String;

          switch (req) {
            case '_upgrade_':
              connManagerCubit.upgradeConnection(uniqueID);
              break;
            default:
              colorChangeCubit.changeColor(
                newColor: req,
                clientID: connManagerCubit.getCurrentClientID(uniqueID),
                connections: connManagerCubit.connections,
              );
          }
        },
        // The client has disconnected.
        // Unsubscribe the channel.
        onDone: () {
          colorChangeCubit.unsubscribe(channel);
          connManagerCubit.removeConnectedClient(uniqueID);
        },
      );
    },
  );

  return handler(context);
}
