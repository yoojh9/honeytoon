import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:honeytoon/services/firestore_api.dart';

class HoneytoonContentApi extends FirestoreApi {
  static final String honeytoonContentApi = "contents";
  HoneytoonContentApi() : super(honeytoonContentApi);

 
  Future<void> setContentDocument(String id, int count, Map data) {
    CollectionReference _ref = super.ref;
    print('id:$id');
    print('count:$count');
    print('data:$data');
    return _ref.document(id).collection('items').document(count.toString()).setData(data);
  }
  
}
