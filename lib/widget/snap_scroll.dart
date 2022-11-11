import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../models/groceries/groceryItems.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/groceries/product.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll({Key? key, required this.onItemFocused, required this.index})
      : super(key: key);
  void Function(int) onItemFocused;
  final int index;
  @override
  _SnapScrollState createState() => _SnapScrollState();
}

int? activeColor = 0;
int? elevation = 0;

class _SnapScrollState extends State<SnapScroll> {
  List<Product> productList = [
    Product('assets/images/1.png', 'assets/images/v5.png', 'Nuts & Beans', 15),
    Product('assets/images/1.png', 'assets/images/v6.png', 'Meat', 15),
    Product('assets/images/1.png', 'assets/images/v2.png', 'Oils', 15),
    Product('assets/images/1.png', 'assets/images/v4.png', 'Meat', 15),
    Product('assets/images/1.png', 'assets/images/v7.png', 'Grains', 15),
    Product('assets/images/1.png', 'assets/images/v8.png', 'Legumes', 15),
    Product('assets/images/1.png', 'assets/images/v9.png', 'Dairy', 15),
    Product('assets/images/1.png', 'assets/images/v1.png', 'Veggies', 15),
    Product('assets/images/1.png', 'assets/images/v3.png', 'Fruits', 15),
  ];

  List<String> groceryIcons = [
    "assets/images/grains.png",
    "assets/images/legumes.png",
    "assets/images/meat.png",
    "assets/images/eggs.png",
    "assets/images/milk.png",
    "assets/images/greens.png",
    "assets/images/grains.png",
    "assets/images/greens.png",
    "assets/images/fruits.png",
    "assets/images/nutsandbeans.png",
    "assets/images/oils.png"
  ];

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

  int selectedGrocery = 1;
  final int _Current = 0;
  String selectedQuantity = "-QTY-";

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

  List<String> listOpt = <String>[];

  List<String> foundIngredients = [];

  void onSwipe(int index) {
    List<String> results = [];
    if (index != -1) {
      results = totalGroceries[selectedGrocery];
    } else {
      results = totalGroceries[selectedGrocery].toList();
    }
    setState(() {
      foundIngredients = results;
    });
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

  Widget _buildItemList(BuildContext context, int index) {
    int selectedIndex;
    final double percentage;
    var color = const Color.fromRGBO(255, 209, 92, 0.1);
    Product product = productList[index];

    if (index == productList.length) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    items:
    List.generate(productList.length, (index) {
      foundIngredients;
    });

    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: SizedBox(
              // color: const Color.fromRGBO(255, 209, 92, 0.1),
              width: 112.w,
              height: 125.h,

              child: Container(
                // height: activeCorlor == index ? 125.h : 80.h,
                // width: activeColor == index ? 112.w : 75.w,
                decoration: BoxDecoration(
                  boxShadow: activeColor == index
                      ? [
                          const BoxShadow(
                            color: Colors.transparent,
                            blurRadius: 3,
                            offset: Offset(0, 4),
                            spreadRadius: 4,
                          ),
                        ]
                      : [
                          const BoxShadow(
                            blurRadius: 0,
                            color: Colors.transparent,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                  borderRadius: activeColor == index
                      ? BorderRadius.circular(10.r)
                      : BorderRadius.circular(0.r),
                  color: activeColor == index
                      ? const Color(0xffFFD15C).withOpacity(0.1)
                      : Colors.transparent,
                  border: Border.all(
                    // width: activeColor == index ? 2.w : 0.w,
                    color: activeColor == index
                        ? Colors.black.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                ),

                // color: const Color.fromRGBO(255, 209, 92, 0.1),

                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 1.h),
                    child: CircularPercentIndicator(
                      radius: 54.0.r,
                      lineWidth: 4.0.w,
                      backgroundColor: Colors.transparent,
                      percent: 0.10,
                      progressColor: Theme.of(context).colorScheme.secondary,
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      center: CircleAvatar(
                        radius: 45.0.r,
                        backgroundColor: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 22.h,
                            ),
                            Image.asset(
                              product.vectorPath,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Visibility(
                              child: Text(
                                // '${percentage.toStringAsFixed(0)} %',
                                '10%',
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // child: CircleAvatar(

                  //   radius: 47.0.r,
                  //   backgroundColor: Colors.white,
                  //   child: Image.asset(
                  //     product.vectorPath,
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            // width: 37.w,
            // height: 17.h,
            child: Text(
              groceries[index],
              style: TextStyle(
                fontWeight:
                    activeColor == index ? FontWeight.w700 : FontWeight.w400,
                fontSize: activeColor == index ? 12.sp : 9.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),

          // margin: EdgeInsets.only(top: 360.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var product;
    var color = const Color.fromRGBO(255, 209, 92, 0.1);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ScrollSnapList(
                      itemBuilder: _buildItemList,
                      itemSize: 150,
                      dynamicItemSize: true,
                      onReachEnd: () {
                        print('Done!');
                      },
                      itemCount: productList.length,
                      // initialIndex: 0,
                      onItemFocus: widget.onItemFocused),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 474.h),
            color: Colors.amberAccent,
            width: 360.w,
            height: 58,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.w, top: 19.h),
                  // child: Text(product.title),
                )
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 193.h),
            // visible: activeColor == index ? true : false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(groceries.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInCubic,
                    height: indic_height(widget.index, index).h,
                    width: indic_height(widget.index, index).w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == widget.index
                            ? const Color(0xfffa9746)
                            : Colors.grey),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          //
        ],
      ),
    );
  }
}
