import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

// class Invoice{
//   final String name;
//   final String number;
//   final  items;
//
// const Invoice({
//     required this.name,
//     required this.number,
//
//     required this.items,
//   });
// }
class ContactModel {
   // String? id;
  String item;
  int price;
  int quantity;

  ContactModel({ required this.item,  required this.price,  required this.quantity});

  // toJson(){
  //   return{
  //     "item" : item,
  //     "price" :price,
  //     "quantity":quantity
  //   };
  // }
  //  ContactModel.fromJSON(Map<String, dynamic> json)
  //      : item = json['name'] as String,price = json['price'] as String,
  //        quantity = json['quantity'] as String;

   // Map<String, dynamic> toJson() => {
   //   'item': item,
   //   'price': price,
   //   'quantity': quantity,
   //
   // };

 // ContactModel.fromJson(Map<String,dynamic> json){
 //
 //
 //
 //  item:json['name'];
 //  price: json['price'];
 //  quantity:json['quantity'];
 //
 //  }
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

