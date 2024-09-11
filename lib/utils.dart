import 'package:intl/intl.dart';

class Utils {
  var outputFormat = DateFormat('dd/MM/yyyy');
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMMMEd().format(date);
}
