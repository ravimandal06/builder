import 'dart:convert';

GroceriesModel groceriesModelFromJson(String str) =>
    GroceriesModel.fromJson(json.decode(str));

String groceriesModelToJson(GroceriesModel data) => json.encode(data.toJson());

class GroceriesModel {
  GroceriesModel({
    required this.user_id,
    required this.groceryName,
    required this.totalQuantity,
    required this.totalQuantityUnits,
  });

  String user_id;
  String groceryName;
  int totalQuantity;
  String totalQuantityUnits;

  factory GroceriesModel.fromJson(Map<String, dynamic> json) => GroceriesModel(
        user_id: json["user_id"],
        groceryName: json["groceriesName"],
        totalQuantity: json["totalQuantity"],
        totalQuantityUnits: json["totalQuantityUnits"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "groceryName": groceryName,
        "totalQuantity": totalQuantity,
        "totalQuantityUnits": totalQuantityUnits,
      };
}
