library firestore;

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDB {
 static FirebaseFirestore? _firestore;
  static FirebaseFirestore get getInstance {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }
}