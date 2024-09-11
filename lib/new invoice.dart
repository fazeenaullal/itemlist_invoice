import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practice_in/invoice.dart';
import 'package:practice_in/main.dart';
import 'contact_form_item.dart';
import 'contact_model.dart';



class NewInvoice extends StatefulWidget {
  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  List<ContactFormItemWidget> contactForms = List.empty(growable: true);
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
    CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () async {
              onSave();
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter Customer Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Enter Customer Contact-Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Text(
                  "Adding items to bill:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E384E),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(height: 15,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: contactForms.length,
                  itemBuilder: (_, index) {
                    return contactForms[index];
                  }),
              const SizedBox(
                height: 50,
              ),

              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    onAdd();

                  });
                },
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        // color: const Color(0xFF444C60),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Add More",
                    ),
                    // style:
                    // GoogleFonts.nunito(color: const Color(0xFFF8F8FF))
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
  onSave() {
    bool allValid = true;

    contactForms
        .forEach((element) => allValid = (allValid && element.isValidated()));

    if (allValid) {

      List<dynamic> names =
      contactForms.map((e) => e!.contactModel.item).toList();
      List<dynamic> numbers =
      contactForms.map((e) => e!.contactModel.price).toList();
      debugPrint("$numbers");
      List<dynamic> mails =
      contactForms.map((e) => e!.contactModel.quantity).toList();
      debugPrint("$mails");
      debugPrint("$names");
      List listItems=[];
      for (int i = 0; i < names.length; i++)
        listItems .add({
          "name": names.toList()[i],
          "price": numbers.toList()[i],
          "quantity":mails.toList()[i]
        });
//       List <ContactModel> data;
//       for (int i = 0; i < listItems.length; i++){
// data=ContactModel(item: listItems[i]['name'], price: listItems[i]['price'], quantity: listItems[i]['quantity']) as List<ContactModel>;}
      // Employee employee = Employee(
      //     name: nameController.text,
      //     age: int.parse(ageController.text),
      //     salary:
      //     int.parse(salaryController.text),
      //     address: address,
      //     items:item,
      //     employeeTraits: employeeTraits);
      // debugPrint("$listItems");
      // Invoice employee = Invoice(
      //     contactModel:data[], employeename: name.text, date:  DateTime.now(), dueDate:  DateTime.now(), );
      ref.add({
        'name': name.text,
        'phone_number':number.text,
        'Items': FieldValue.arrayUnion(listItems),

      })
      .whenComplete(() {

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            });

    } else {
      debugPrint("Form is Not Valid");
    }
  }

  //Delete specific form
  onRemove(ContactModel contact) {
    setState(() {
      int index = contactForms
          .indexWhere((element) => element.contactModel.item == contact.item);

      if (contactForms != null) contactForms.removeAt(index);
    });
  }


  onAdd() {
    setState(() {

      ContactModel _contactModel = ContactModel(item: '', price:0, quantity:0);
      // ContactModel _contactModel = ContactModel(id: contactForms.length, name: '', email: '', number: '');
      contactForms.add(ContactFormItemWidget(
        index: contactForms.length,
        contactModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }
}
