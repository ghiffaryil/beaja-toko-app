import 'package:intl/intl.dart';

extension TimeHelper on DateTime {
  String formatTime() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }
}
