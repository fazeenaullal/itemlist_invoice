// ignore_for_file: prefer_null_aware_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice_in/model/address.dart';
// import 'package:practice_in/contact_model.dart';


class Employee {
  
  final String name;
  final String number;
  
  final  ContactModel contactModel;
  // final List<String>? employeeTraits;
  Employee(
      {
      required this.name,
      required this.number,
      required this.contactModel,
     });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number':number,
      'contactModel': contactModel.toMap()
          };
  }

  Employee.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      :
        name = doc.data()!["name"],
        number=doc.data()!["number"],
        contactModel = ContactModel.fromMap(doc.data()!["contactModel"]);


}
