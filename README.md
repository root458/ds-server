# Colorfy API

A real-time background color changer server using [Dart Frog](https://dartfrog.vgv.dev). Test the [live app here](https://colorfy-web.web.app/#/).

## Project Description

Colorfy API is a real-time server utilizing websockets that allows multiple clients to connect and go on a color war with each other. The application is built using Dart Frog, a backend solution provided by [VeryGoodVentures](https://verygood.ventures/?utm_source=dartfrog&utm_medium=docs&utm_campaign=df) Flutter Software Company.

The Colorfy API allows clients to connect and assigns them ranks based on the order they connect, with the first client receiving rank 0, the second client receiving rank 1, and so on. Clients can then send commands to the server via websocket channels to change the background color of all clients with a lower rank than themselves. The Dart Frog server manages these requests and ensures that higher-ranked clients cannot execute commands sent by lower-ranked clients.

One of the challenges faced during the development of this project was implementing the rank upgrade between clients. The challenge lied in how to know that a client had disconnected and availing this rank for the clients to determine whether an upgrade was necessary. This was overcome by using [broadcast bloc package](https://pub.dev/packages/broadcast_bloc) to provide real-time notifications and synchronization of data between the server and all clients involved. A challenge came also when deciding how to handle disconnections and to use a data structure that will maintain the ranks and allow only willing users to upgrade their ranks. This was gracefully solved using HashMaps.

## How to install and run the project
1. Clone the repository using git clone 
```bash
git clone https://github.com/root458/ds-server
```
2. Ensure that DartLang is installed on your system. If not, follow the instructions [here](https://dart.dev/get-dart).
3. Ensure that Dart Frog is installed on your system. If not, follow the instructions [here](https://dartfrog.vgv.dev/docs/overview).
4. Navigate to the project directory. Run:
```bash
dart pub get
```
```bash
dart_frog dev
```
This launches the server locally for you.

## How to use the project
1. This API serves this [application](https://github.com/root458/neglected-client).
2. Tap any of the colors and watch the change. The server delivers your rank after your first color change.
3. Feel free to experiment with the maximum connections the server should handle from this file:
```bash
lib\connmanager\middleware\connmanager_provider.dart
```

Navigate to ws route which handled the color notifications and have fun going through the code:
```bash
routes\ws.dart
```

The server hot reloads so no need to restart it. Have fun!

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
