

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_in/service/database_service.dart';

// import 'addnote.dart';
import 'editnote.dart';
import 'new invoice.dart';
import 'report.dart';
// import 'editnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Invoice Details",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 0, 11, 133),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService service = DatabaseService();
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('report').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(252, 0, 221, 142),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => NewInvoice()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(62,0, 221, 142),
        title: Text('Customers'),
      ),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                return Dismissible(
                  onDismissed: (direction) async {
await service.deleteCustomer(snapshot.data!.docs[index].id.toString());

                  },
                  key: UniqueKey(),
                  background: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(16.0)),
                    padding: const EdgeInsets.only(right: 28.0),
                    alignment: AlignmentDirectional.centerEnd,
                    child: const Text(
                      "DELETE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  resizeDuration: const Duration(milliseconds: 200),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              reportt(
                                docid: snapshot.data!.docs[index],
                              ),
                              // editnote(docid: snapshot.data!.docs[index]),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            title: Text(
                              // snapshot.data!.docChanges[index].doc['name'],
                              snapshot.data!.docs[index].get('name'),
                              
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
