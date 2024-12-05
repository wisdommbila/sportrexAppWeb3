import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

Logger getLogger(Object value) {
  return Logger(
    printer: SimpleLogPrinter(
      value.toString(),
    ),
  );
}

class SimpleLogPrinter extends LogPrinter {
  final String className;

  SimpleLogPrinter(
      this.className,
      );

  @override
  List<String> log(LogEvent event) {
    AnsiColor? color = PrettyPrinter.levelColors[event.level];
    String? emoji = PrettyPrinter.levelEmojis[event.level];
    if (kDebugMode) {
      print(
        color!(
          '$emoji $className - ${event.message}',
        ),
      );
    }

    return [];
  }
}
