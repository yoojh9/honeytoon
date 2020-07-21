import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreApi {
  final _firestore = Firestore.instance;
  CollectionReference _collectionReference;

  FirestoreApi(String collectionPath) {
    _collectionReference = _firestore.collection(collectionPath);
  }

  Stream<QuerySnapshot> streamCollection() {
    return _collectionReference.getDocuments().asStream();
  }

  Future<QuerySnapshot> getCollection() {
    return _collectionReference.getDocuments();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _collectionReference.document(id).get();
  }

  Future<DocumentReference> addDocument(Map data) {
    return _collectionReference.add(data);
  }

  Future<DocumentReference> updateDocument(String id, Map data) {
    return _collectionReference.document(id).updateData(data);
  }

  Future<void> deleteDocument(String id) {
    return _collectionReference.document(id).delete();
  }
}
