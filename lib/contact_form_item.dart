import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contact_model.dart';





class ContactFormItemWidget extends StatefulWidget {
  ContactFormItemWidget(
      { Key? key, required this.contactModel, required this.onRemove, this.index})
      : super(key: key);

  final index;
  ContactModel contactModel;
  final Function onRemove;
  final state = _ContactFormItemWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool isValidated() => state.validate();
}

class _ContactFormItemWidgetState extends State<ContactFormItemWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item - ${widget.index}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.orange),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                // Clear All forms Data
                                widget.contactModel.item = "";
                                widget.contactModel.quantity;
                                widget.contactModel.price ;
                                widget._nameController.clear();
                                widget._contactController.clear();
                                widget._emailController.clear();
                              });
                            },
                            child: Text(
                              "Clear",
                              style: TextStyle(color: Colors.blue),
                            )),
                        TextButton(
                            onPressed: () => widget.onRemove(),
                            child: Text(
                              "Remove",
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    ),
                  ],
                ),
                TextFormField(
                  controller: widget._nameController,
                  // initialValue: widget.contactModel.item,
                  onChanged: (value) => widget.contactModel.item = value,
                  onSaved: (value) => widget.contactModel.item = value!,
                  validator: (value) => value!.length > 0 ? null : "Enter Name",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter the item-name",
                    labelText: "item",
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: widget._contactController,
                  onChanged: (value) => widget.contactModel.quantity = int.parse(value),
                  onSaved: (value) => widget.contactModel.quantity =int.parse(value!),
                  validator: (value) =>
                  value!.length > 0 ? null : "Enter the quantity",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter quantity",
                    labelText: "quantity",
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: widget._emailController,
                  onChanged: (value) => widget.contactModel.price= int.parse(value),
                  onSaved: (value) => widget.contactModel.price = int.parse(value!),
                  validator: (value) =>
                  value!.length > 0 ? null : "Enter the price",
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter the price",
                    labelText: "price",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}
