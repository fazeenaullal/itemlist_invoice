import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> deleteCustomer(String documentId) async {
    await _db.collection("report").doc(documentId).delete();
  }
}