// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Diet/individual_grocery.dart';
import '../controller/groceries/groceries_controller.dart';
import '../models/groceries/groceryItems.dart';
import '../widget/snap_scroll.dart';

// import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class GroceryBuilder extends StatefulWidget {
  const GroceryBuilder({super.key});

  @override
  State<GroceryBuilder> createState() => _GroceryBuilderState();
}

class _GroceryBuilderState extends State<GroceryBuilder> {
  bool automate = false;
  String dropdownvalue = "1 Week";
  List<String> weeks = ["1 Week", "2 Weeks"];

  List<String> quantities = ["100", "250", "500", "750", "1"];
  List<String> measuringUnit = ["gm", "gm", "gm", "gm", "kg"];
  List<String> groceries = [
    "Grains & Cereals",
    "Beans & Legumes",
    "Meat",
    "Eggs",
    "Milk & Dairy",
    "Leafy Greens",
    "Roots & Tubers",
    "Other Veg",
    "Fruits",
    "Nuts & Seeds",
    "Oils & Fats"
  ];

  List<List<String>> totalGroceries = [
    grainsCereals,
    beansLegumes,
    meat,
    eggs,
    milkDairy,
    leafyGreens,
    rootsTubers,
    otherVeg,
    fruits,
    nutsSeeds,
    oilFats,
  ];

  Map<String, String> conversionMap = {
    "CEREALS AND MILLETS": "Grains & Cereals",
    "GRAIN LEGUMES": "Beans & Legumes",
    "MEAT": "Meat",
    "EGG AND EGG PRODUCTS": "Eggs",
    "MILK AND MILK PRODUCTS": "Milk & Dairy",
    "GREEN LEAFY VEGETABLES": "Leafy Greens",
    "ROOTS, TUBERS, AND BULBS": "Roots & Tubers",
    "OTHER VEGETABLES": "Other Veg",
    "FRUITS": "Fruits",
    "NUTS AND OIL SEEDS": "Nuts & Seeds",
    "FATS AND OILS": "Oils & Fats",
  };

  Map<String, double> categoryPercent = {
    "Grains & Cereals": 0.0,
    "Beans & Legumes": 0.0,
    "Meat": 0.0,
    "Eggs": 0.0,
    "Milk & Dairy": 0.0,
    "Leafy Greens": 0.0,
    "Roots & Tubers": 0.0,
    "Other Veg": 0.0,
    "Fruits": 0.0,
    "Nuts & Seeds": 0.0,
    "Oils & Fats": 0.0
  };

  int selectedGrocery = 0;
  int _Current = 0;
  String selectedQuantity = "-QTY-";

  Map<String, String> quantityMap = {};
  Map<String, int> countMap = {};
  Map<String, String> measuringUnitMap = {};
  Map<String, bool> adddeToList = {};

  SnackBar showAddedtoListSnackBar(String title) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.black.withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: 240.h, left: 10.w, right: 10.w),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_rounded,
            size: 15.h,
            color: Colors.white,
          ),
          SizedBox(width: 9.w),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
            ),
          ),
        ],
      ),
    );
  }

  double indic_height(int heig, int ind) {
    if (ind > heig) {
      double ans = (6 * (1 - ind * 0.1)).h;
      return ans;
    } else if (ind < heig) {
      double ans = (7.5 - 6 * (1 - ind * 0.1)).h;
      return ans;
    }
    return 6.h;
  }

  Color getColor(double percent) {
    if (percent <= 0.25) {
      return const Color(0xffFFD15C);
    } else if (percent <= 0.50) {
      return const Color(0xff24F1A7);
    } else if (percent <= 0.75) {
      return const Color(0xfffa9746);
    } else if (percent <= 1.0) {
      return const Color(0xffF88968);
    } else {
      return const Color(0xffFF5A35);
    }
  }

  double getPercent() {
    return 0.0;
  }

  List<String> foundIngredients = [];

  void searchFilter(String value) {
    List<String> results = [];
    if (value.isEmpty) {
      results = totalGroceries[selectedGrocery];
    } else {
      results = totalGroceries[selectedGrocery]
          .where((ingredient) =>
              ingredient.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      foundIngredients = results;
    });
  }

  IndividualGrocery individualGrocery =
      IndividualGrocery(Energy: [0.0, "", ""]);

//percentage-UI

  var groceriesController = Get.put(GroceriesController());

  void getPercentage() async {
    final groceryData = await groceriesController.sendGroceries();
    final data = jsonDecode(groceryData);
    print(data);
    individualGrocery = IndividualGrocery.fromJson(data);
    print("Individual Grocery Data => ${individualGrocery.Energy}");
    categoryPercent[conversionMap[individualGrocery.Energy[2]]!] =
        individualGrocery.Energy[0];
    //groceriesController.getUserGroceries();
    setState(() {});
  }

  void deleteGrocery() async {
    print("Inside delete Grocery");
    final groceryData = await groceriesController.deleteGrocery();
    final data = jsonDecode(groceryData);
    print("Deleted data is $data");
    individualGrocery = IndividualGrocery.fromJson(data);
    print("Individual Grocery Data => ${individualGrocery.Energy}");
    categoryPercent[conversionMap[individualGrocery.Energy[2]]!] =
        individualGrocery.Energy[0];
    setState(() {});
  }

  bool selected = false;
  bool toggle = false;
  String val = '';
  String val1 = '';

  ShapeBorder? get a => null;

  ShapeBorder? get b => null;

  double get t => 0;
//

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Material(
              elevation: 1.0,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 18.w, top: 25.h),
                height: 65.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: Text(
                    "Grocery Builder",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: "ProductSans Medium",
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset("assets/images/illus.png"),
            ),
            Container(
              margin: EdgeInsets.only(left: 18.w, top: 110.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pick for",
                            style: TextStyle(
                                fontFamily: "ProductSans Regular",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          SizedBox(
                            width: 15.h,
                          ),
                          DropdownButton(
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            items: weeks.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Row(
                                  children: [
                                    Text(
                                      items,
                                      style: TextStyle(
                                        fontFamily: "Roboto Regular",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff0C6E54),
                                      ),
                                    ),
                                    if (items == "2 Weeks") ...[
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      // Image.asset("assetsimages//premiumIcon.png")
                                    ]
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                            value: dropdownvalue,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Row(
                          children: [
                            Switch(
                              value: automate,
                              activeColor: const Color(0xffffffff),
                              activeTrackColor: const Color(0xfffa9746),
                              onChanged: (value) {
                                setState(() {
                                  automate = value;
                                });
                              },
                            ),

                            Text(
                              "Automate",
                              style: TextStyle(
                                fontFamily: "Roboto Regular",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            // SizedBox(width: 5.w,),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 164.h),
              width: 360.w,
              height: 217.h,
              // color: Colors.white,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      // color: Colors.amber,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                      spreadRadius: 1,
                    ),
                  ],
                  border: Border(
                      bottom: BorderSide(
                        width: 0.2,
                      ),
                      top: BorderSide(width: 0.1))),

              child: Center(
                child: SnapScroll(
                  index: _Current,
                  onItemFocused: (index) {
                    setState(() {
                      activeColor = index;
                      // onSwipe(index);
                      selectedIndex:
                      _Current;

                      _Current = index;
                      selectedGrocery = index;
                      foundIngredients = totalGroceries[selectedGrocery];

                      print(groceries[selectedGrocery]);
                    });
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 401.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 23.w),
                child: Material(
                  elevation: 6.0,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 13.w),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 20.h,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            enableSuggestions: false,
                            onChanged: (value) {
                              print(value);
                              searchFilter(value);
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: selectedGrocery != -1
                                  ? "Search in ${groceries[selectedGrocery]}"
                                  : "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 8.h,
                              ),
                              isDense: true,
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 474.h),
                width: double.infinity,
                height: 380.h,
                color: Colors.amber[50],
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: foundIngredients.length,
                        itemBuilder: (BuildContext context, index) {
                          return Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                                width: 360,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text(
                                        'Wheat Flour',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 17,
                                      ),
                                      if (selected == false) ...[
                                        InkWell(
                                            onTap: () async {
                                              var quantity = await Qty(
                                                  context, foundIngredients[0]);
                                              setState(() {
                                                selected = true;
                                                val = quantity["selectedValue"];
                                                val1 = quantity['selectedUnit'];
                                              });
                                            },
                                            child: Container(
                                              width: 88,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.grey,
                                                  )),
                                              child: Center(
                                                child: Row(children: const [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text('-QTY-',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Center(
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ))
                                      ],
                                      if (selected == true) ...[
                                        InkWell(
                                          onTap: () async {
                                            var quantity = await Qty(
                                                context, foundIngredients[0]);
                                            setState(() {
                                              selected = true;
                                              val = quantity["selectedValue"];
                                              val1 = quantity['selectedUnit'];
                                            });
                                          },
                                          child: Text("$val $val1",
                                              style: const TextStyle(
                                                color: Colors.blue,
                                              )),
                                        ),
                                      ],
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: 98,
                                        height: 36,
                                        child: AnimatedToggleSwitch<bool>.dual(
                                            current: toggle,
                                            first: false,
                                            second: true,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            dif: 5,
                                            borderColor: Colors.transparent,
                                            borderWidth: 5.0,
                                            height: 50,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0, 1.5),
                                              ),
                                            ],
                                            onChanged: (b) => setState(() {
                                                  toggle = b;
                                                  if (toggle == false) {
                                                    setState(() {
                                                      selected = false;
                                                    });
                                                  }
                                                }),
                                            colorBuilder: (b) =>
                                                b ? Colors.red : Colors.orange,
                                            iconBuilder: (value) => value
                                                ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape: BoxShape
                                                                .circle),
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                            textBuilder: (value) => value
                                                ? const Center(
                                                    child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 9,
                                                        color: Color.fromRGBO(
                                                            68, 68, 68, 1)),
                                                  ))
                                                : const Center(
                                                    child: Text('Add',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 10,
                                                            color:
                                                                Color.fromRGBO(
                                                                    68,
                                                                    68,
                                                                    68,
                                                                    1))),
                                                  )),
                                      ),
                                    ])),
                          );
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> Qty(BuildContext context, String groceryItem) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          int count = 1;
          var selectedValue;
          var selectedUnit;
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                insetPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 342.h,
                  width: 338.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const CloseIconWidget(),
                      Container(
                        height: 308.h,
                        width: 328.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 16.h, left: 14.w, right: 21.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    groceryItem,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (count > 0) {
                                              count--;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          color: const Color(0xfffa9746),
                                          size: 20.h,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text("$count"),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            count++;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 20.h,
                                          color: const Color(0xfffa9746),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.w),
                              child: const Text(
                                "Select the Quantity",
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 11.w),
                              child: Container(
                                width: 305.w,
                                height: 171.h,
                                padding: EdgeInsets.only(top: 10.h, left: 21.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color:
                                      const Color(0xffCBCBCB).withOpacity(0.1),
                                ),
                                child: ListView.builder(
                                    itemCount: quantities.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 6.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 16.h,
                                              width: 16.w,
                                              child: Radio(
                                                activeColor:
                                                    const Color(0xfffa9746),
                                                value: quantities[index],
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                groupValue: selectedValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedValue = value;
                                                    selectedUnit =
                                                        measuringUnit[index];
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 11.w),
                                            Text(
                                              "${quantities[index]} ${measuringUnit[index]}",
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                            SizedBox(height: 17.h),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: DialogButton(
                                  onPressed: () {
                                    setState(() {
                                      String res = "$count x $selectedValue";
                                      Navigator.pop(context, {
                                        "selectedValue": selectedValue,
                                        "count": count,
                                        "selectedUnit": selectedUnit,
                                      });
                                      print("Selected unit=$selectedUnit");
                                      // print(quantityMap);
                                    });
                                  },
                                  yes: false,
                                  name: "Done",
                                  color: const Color(0xfffa9746),
                                  width: 83.w,
                                  height: 29.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton(
      {Key? key,
      required this.onPressed,
      required this.yes,
      required this.name,
      required this.color,
      required this.width,
      required this.height})
      : super(key: key);
  final Function onPressed;
  final String name;
  final bool yes;
  final Color color;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RawMaterialButton(
        splashColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: yes == true
              ? BorderSide(
                  width: 1.w,
                  color: color,
                )
              : BorderSide.none,
        ),
        fillColor: yes == true ? Colors.white : color,
        onPressed: () => onPressed(),
        child: Text(
          name,
          style: TextStyle(
            color: yes == true ? color : Colors.white,
            fontSize: 16.sp,
            fontFamily: "ProductSans Regular",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class CloseIconWidget extends StatelessWidget {
  const CloseIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: const BoxDecoration(
        color: Color(0xffF7F7F7),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context, "-QTY-");
        },
        child: Icon(
          Icons.close,
          size: 24.h,
          color: Colors.black,
        ),
      ),
    );
  }
}
