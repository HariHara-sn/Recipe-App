import 'package:logger/logger.dart';

/// Singleton logger for the whole app
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 90,
    colors: true,
    printEmojis: true,
  ),
);
