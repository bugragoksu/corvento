import 'package:eventapp/src/model/category.dart';
import 'package:eventapp/src/services/api/firebase_api.dart';

class CategoryRepository {
  FirebaseAPI _api = FirebaseAPI();
  Future<List<Category>> getCategories() async {
    return await _api.getCategories();
  }
}
