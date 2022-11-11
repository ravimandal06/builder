import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/groceries/groceries_model.dart';
import '../../services/networkHandler/network_handler.dart';

final getStorage = GetStorage();

class GroceriesController extends GetxController {
  // TextEditingController user_id = TextEditingController();
  TextEditingController groceriesName = TextEditingController();
  TextEditingController totalQuantity = TextEditingController();
  TextEditingController totalQuantityUnits = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // var groceriesName = "Ragi";
  // var totalQuantity = 1;
  // var totalQuantityUnits = "kg";
  Future<String> sendGroceries() async {
    var userId = getStorage.read("userId");
    print(userId);
    GroceriesModel groceriesModel = GroceriesModel(
      user_id: userId,
      groceryName: groceriesName.text,
      totalQuantity: int.parse(totalQuantity.text),
      totalQuantityUnits: totalQuantityUnits.text,
    );
    String response = await NetworkHandler.post(
        groceriesModelToJson(groceriesModel), "groceries/calculate-nutrients");

    //print(" json Decode body ==> ${jsonDecode(response)}");
    print(response);
    return response;
  }

  void getUserGroceries() async {
    var userId = getStorage.read("userId");
    var response =
        await NetworkHandler.get("groceries/get-allnutrietnts/$userId");
    print("Response body ==> ${response.body}");
  }

  Future<String> deleteGrocery() async {
    print("Category is ${categoryController.text}");
    var userId = getStorage.read("userId");
    Object data = {
      "user_id": userId,
      "name": groceriesName.text,
      "foodCategory": categoryController.text,
    };
    String response = await NetworkHandler.delete(
      "groceries/delete-user-grocery",
      data,
    );
    print(response);
    return response;
  }
}
