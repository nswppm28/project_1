import 'dart:convert';
import 'package:project_1/models/restaurant.dart';
import 'package:project_1/services/api_caller.dart';

class RestaurantRepository {
  Future<List<Menu>> getMenu() async {
    try {
      var result = await ApiCaller().get('menu?_embed=reviews');
      List list = jsonDecode(result);
      List<Menu> RestaurantList =
          list.map<Menu>((item) => Menu.fromJson(item)).toList();
      return RestaurantList;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }

  Future<void> addMenu({required String name, required double price}) async {
    try {
      var result = await ApiCaller()
          .post('menu', params: {'name': name, 'price': price});
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}
