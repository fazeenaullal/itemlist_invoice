import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:invoice_demo/invoice.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:practice_in/utils.dart';
import 'package:printing/printing.dart';

import 'contact_model.dart';
import 'invoice.dart';




class reportt extends StatefulWidget {
  DocumentSnapshot docid;
  reportt({required this.docid});
  @override
  State<reportt> createState() => _reporttState(docid: docid);
}

class _reporttState extends State<reportt> {
  DocumentSnapshot docid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  _reporttState({required this.docid}){
    print("helloooo");
    final lis = _db.collection("report").doc('${docid}').snapshots();
    print("helloooo");
    print(lis);
    // var doc_id2 = docid.reference.snapshots();
  }
  final pdf = pw.Document();

  var name;
var itemname;
  var quantity;
  var price;
  var docno;
  String? getRange;
  var bill;
  List<ContactModel> itemList=[];
  void initState() {
    super.initState();
    setState(() {
      // getRange = widget.docid;

      name = widget.docid.get('name');
      List<dynamic> markMap =widget.docid.get('Items');

            print(markMap);
      markMap.forEach((element) {
        itemList.add(new ContactModel
          (item: element['name'],
            price: element['price'],
            quantity: element['quantity']));

      });
      print("itemsssss");
      print(itemList);
      // quantity = widget.docid.get('quantity');
      // price = widget.docid.get('price');

      // bill = int.parse(quantity) * int.parse(price);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: 1000,
      // useActions: false,
      // canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }
  // child: StreamBuilder(
  // stream: FirebaseFirestore.instance.collection("coin").snapshots(),
  // builder: (context, snapshot) {
  // if (!snapshot.hasData) {
  // return Loder();
  // }
  // return ListView.builder(
  // itemCount: snapshot.data.document.length,
  // itemBuilder: (BuildContext context, int index) {
  // Map<dynamic, dynamic> map = snapshot.data.documents[index];
  // final  coinLinks = map["coinLink"] as List<Map<String,dynamic>>;
  // return ListTile(
  // title: Column(
  // children: coinLinks.map((coinLink){
  // return Text(coinLink["title"]);
  // }).toList()
  // ),
  // );
  // },
  // );
  //
  // String lastname = itemlist[i]['item'];
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final date = DateTime.now();

    final dueDate = date.add(Duration(days: 7));
    final number= '${DateTime.now().year}-9999';
    final titles = <String>[
      // 'Invoice Number:',
      'Invoice Date:',

      'Due Date:'
    ];
    final data = <String>[
      // number,
      Utils.formatDate(date),

      Utils.formatDate(dueDate),
    ];
    final headers = [
      'Description',

      'Quantity',
      'Unit Price',
      'Total'
    ];
    final invoice = Invoice(
      items: [
        InvoiceItem(
          description: "title",
          date: DateTime.now(),
           // quantity: int.parse('quantity'),

          // unitPrice: double.parse(price),
        ),
    //     // InvoiceItem(
    //     //   description: 'Water',
    //     //   date: DateTime.now(),
    //     //   quantity: 8,
    //     //
    //     //   unitPrice: 0.99,
    //     // ),
    //     // InvoiceItem(
    //     //   description: 'Orange',
    //     //   date: DateTime.now(),
    //     //   quantity: 3,
    //     //
    //     //   unitPrice: 2.99,
    //     // ),
    //     // InvoiceItem(
    //     //   description: 'Apple',
    //     //   date: DateTime.now(),
    //     //   quantity: 8,
    //     //
    //     //   unitPrice: 3.9,
    //     // ),
    //     // InvoiceItem(
    //     //   description: 'Mango',
    //     //   date: DateTime.now(),
    //     //   quantity: 1,
    //     //
    //     //   unitPrice: 1.59,
    //     // ),
    //     // InvoiceItem(
    //     //   description: 'Blue Berries',
    //     //   date: DateTime.now(),
    //     //   quantity: 5,
    //     //
    //     //   unitPrice: 0.99,
    //     // ),
    //     // InvoiceItem(
    //     //   description: 'Lemon',
    //     //   date: DateTime.now(),
    //     //   quantity: 4,
    //     //
    //     //   unitPrice: 1.29,
    //     // ),
      ],
    );
    // final itemlist= ContactModel(item:itemname , price: price, quantity: quantity);
// late Invoice data1;
//     data1 = ModalRoute.of(context)!.settings.arguments as Invoice;
// print(data1);
//     String names =data1.contactModel.item.toString();
    // final data2 = data1.contactModel.item.length {
    //   final total = 3 * 2;
    //
    //   return [
    //     item.description,
    //     Utils.formatDate(item.date),
    //     // '${item.quantity}',
    //     // '\$ ${item.unitPrice}',
    //
    //     '\$ ${total.toStringAsFixed(2)}',
    //   ];
    // }).toList();
    // final data1 = invoice.items.map((item) {
    //   final total = 3 * 2;
    //
    //   return [
    //     item.description,
    //     Utils.formatDate(item.date),
    //     // '${item.quantity}',
    //     // '\$ ${item.unitPrice}',
    //
    //     '\$ ${total.toStringAsFixed(2)}',
    //   ];
    // }).toList();
    final netTotal = itemList
        .map((item) => item.price * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    final data1 = itemList.map((item) {
      final total = item.price * item.quantity;

      return [
        item.item,
        // Utils.formatDate(DateTime.now()),
         '${item.quantity}',
         ' ${item.price}',

        ' ${total}',
      ];
    }).toList();

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    // final image = await imageFromAssetBundle('assets/r2.svg');

    // String? _logo = await rootBundle.loadString('assets/r2.svg');
    final style1 = pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 14);
    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 2,
            marginLeft: 40,
            marginRight: 40,
            marginTop: 2,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 3 * PdfPageFormat.cm),
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text( name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 40,)),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: List.generate(titles.length, (index) {
                            final title = titles[index];
                            final value = data[index];

                            return buildText(title: title, value: value, width: 200);
                          }),
                        ),
                      ]),
                  pw.SizedBox(height: 3 * PdfPageFormat.cm),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'INVOICE',
                        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),

                      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
                    ],
                  ),
                  pw.Table.fromTextArray(
                    headers: headers,
                    data: data1,
                    border: null,
                    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                    cellHeight: 30,
                    cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.centerRight,
                      2: pw.Alignment.centerRight,
                      3: pw.Alignment.centerRight,
                      4: pw.Alignment.centerRight,
                      5: pw.Alignment.centerRight,
                    },
                  ),
                  pw.Divider(),
                  pw.Container(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Row(
                      children: [
                        pw.Spacer(flex: 6),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              buildText(
                                title: 'Total amount',

                                // titleStyle: TextStyle(
                                //   fontSize: 14,
                                //   fontWeight: FontWeight.bold,
                                // ),
                                value:netTotal.toString(),
                                unite: true,
                              ),
                              pw.SizedBox(height: 2 * PdfPageFormat.mm),
                              pw.Container(height: 1, color: PdfColors.grey400),
                              pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                              pw.Container(height: 1, color: PdfColors.grey400),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // pw.Flexible(
                  //   child: pw.SvgImage(
                  //     svg: _logo,
                  //     height: 100,
                  //   ),
                  // ),
                  // pw.SizedBox(
                  //   height: 20,
                  // ),
                  // pw.Center(
                  //   child: pw.Text(
                  //     'Final Bill',
                  //     style: pw.TextStyle(
                  //       fontSize: 50,
                  //     ),
                  //   ),
                  // ),
                  // pw.SizedBox(
                  //   height: 20,
                  // ),
                  // pw.Divider(),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Customer_name : ',
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //     pw.Text(
                  //       name,
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Item_name : ',
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //     pw.Text(
                  //       itemname,
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Quantity : ',
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //     pw.Text(
                  //       quantity,
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Price : ',
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //     pw.Text(
                  //       price,
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // pw.Divider(),
                  // pw.Row(
                  //   mainAxisAlignment: pw.MainAxisAlignment.center,
                  //   children: [
                  //     pw.Text(
                  //       'Total : ',
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //     pw.Text(
                  //       bill.toString(),
                  //       style: pw.TextStyle(
                  //         fontSize: 50,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ));
        },
      ),
    );

    return doc.save();
  }
  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    // TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 20);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
