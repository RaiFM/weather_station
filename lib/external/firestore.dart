class Firestore {
  static Firestore? _firestore;

  Firestore get getInstace {
    _firestore ??= Firestore();
    return _firestore!;
  }
}
