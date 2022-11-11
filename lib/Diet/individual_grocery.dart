import 'dart:convert';

IndividualGrocery individualGroceryFromJson(String str) =>
    IndividualGrocery.fromJson(json.decode(str));

String individualGroceryToJson(IndividualGrocery data) =>
    json.encode(data.toJson());

class IndividualGrocery {
  IndividualGrocery({
    required this.Energy,
  });

  List<dynamic> Energy;

  factory IndividualGrocery.fromJson(Map<String, dynamic> json) =>
      IndividualGrocery(
        Energy: List<dynamic>.from(json["Energy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Energy": List<dynamic>.from(Energy.map((x) => x)),
      };
}
