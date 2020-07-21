import 'package:honeytoon/services/firestore_api.dart';

class HoneytoonMetaApi extends FirestoreApi {
  static final String honeytoonMetaApi = "toons";
  HoneytoonMetaApi() : super(honeytoonMetaApi);
}
