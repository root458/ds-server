import 'package:dart_frog/dart_frog.dart';
import 'package:distributed_server/colorchange/cubit/color_change_cubit.dart';

final _colorChange = ColorChangeCubit();

/// Provide the ColorChange instance via `RequestContext`.
final colorChangeProvider = provider<ColorChangeCubit>((_) => _colorChange);
