// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
// import 'package:login/Screens/components/toggle.dart';

class Tile extends StatefulWidget {
  const Tile({Key? key}) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool selected = false;
  bool toggle = false;
  String val = '';
  String val1 = '';

  ShapeBorder? get a => null;
  List<String> quantities = ["100", "250", "500", "750", "1"];
  List<String> measuringUnit = ["gm", "gm", "gm", "gm", "kg"];
  List<String> foundIngredients = ["hi"];

  ShapeBorder? get b => null;

  double get t => 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Material(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Wheat Flour',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 17,
                  ),
                  if (selected == false) ...[
                    InkWell(
                        onTap: () async {
                          var quantity =
                              await Qty(context, foundIngredients[0]);
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
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )),
                          child: Center(
                            child: Row(children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text('-QTY-',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                ),
                              ),
                            ]),
                          ),
                        ))
                  ],
                  if (selected == true) ...[
                    InkWell(
                      onTap: () async {
                        var quantity = await Qty(context, foundIngredients[0]);
                        setState(() {
                          selected = true;
                          val = quantity["selectedValue"];
                          val1 = quantity['selectedUnit'];
                        });
                      },
                      child: Text(val+" "+val1,
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ),
                  ],
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 98,
                    height: 36,
                    child: AnimatedToggleSwitch<bool>.dual(
                        current: toggle,
                        first: false,
                        second: true,
                        borderRadius: BorderRadius.circular(100),
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
                        colorBuilder: (b) => b ? Colors.red : Colors.orange,
                        iconBuilder: (value) => value
                            ? Container(
                                height: 20,
                                width: 20,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            : Container(
                                height: 20,
                                width: 20,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                        textBuilder: (value) => value
                            ? Center(
                                child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9,
                                    color: Color.fromRGBO(68, 68, 68, 1)),
                              ))
                            : Center(
                                child: Text('Add',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Color.fromRGBO(68, 68, 68, 1))),
                              )),
                  ),
                ])),
      ),
      ),
    );

    // ignore: dead_code
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
                      CloseIconWidget(),
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
                                          color: Color(0xfffa9746),
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
                                          color: Color(0xfffa9746),
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
                              child: Text(
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
                                  color: Color(0xffCBCBCB).withOpacity(0.1),
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
                                                activeColor: Color(0xfffa9746),
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
                                  color: Color(0xfffa9746),
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
