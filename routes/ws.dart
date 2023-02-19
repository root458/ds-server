import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:distributed_server/colorchange/color_change.dart';
import 'package:distributed_server/connmanager/connmanager.dart';

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
      final colorChangeCubit = context.read<ColorChangeCubit>()
        ..subscribe(channel);

      // Send the current color to the new client.
      channel.sink.add(colorChangeCubit.state);

      // Listen for messages from the client.
      channel.stream.listen(
        (newColorReq) => colorChangeCubit.changeColor(newColorReq as String),
        // The client has disconnected.
        // Unsubscribe the channel.
        onDone: () {
          colorChangeCubit.unsubscribe(channel);
          connManagerCubit.removeConnectedClient(address.address);
        },
      );
    },
  );

  return handler(context);
}
