import 'package:practice_in/contact_model.dart';

class Invoice {



  final List<InvoiceItem> items;

  const Invoice( {
   required this.items
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  // final int quantity;

  // final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    // required this.quantity,

    // required this.unitPrice,
  });
}
