import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final formatterAmount = formatter.format(amount);
  return '$formatterAmount,-';
}
