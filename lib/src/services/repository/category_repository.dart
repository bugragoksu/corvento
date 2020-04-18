import 'package:eventapp/src/model/category.dart';
import 'package:eventapp/src/services/api/firebase_api.dart';
import 'package:eventapp/src/services/api/server_api.dart';

class CategoryRepository {
  // FirebaseAPI _api = FirebaseAPI();
  ServerAPI _server = ServerAPI();

  Future<List<Category>> getCategories() async {
    return await _server.getCategories();
  }
}
