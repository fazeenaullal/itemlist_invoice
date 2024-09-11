class ContactModel {
  final String item;
  final int price;
  final int quantity;

  ContactModel(
      {required this.item,
      required this.price,
      required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'price': price,
      'quantity': quantity,
    };
  }

  ContactModel.fromMap(Map<String, dynamic> addressMap)
      : item = addressMap["item"],
        price = addressMap["price"],
        quantity = addressMap["quantity"];
}
