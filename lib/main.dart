import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'screen/grocery_builder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WholesomeEten',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.orange,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),

          routes: GetRoutes.routes,
          initialRoute: GetRoutes.grocery,
        );
      },
    );
  }
}

class GetRoutes {
  static String grocery = '/grocery';
  static var routes = {
    grocery: (_) => const GroceryBuilder(),
  };
}
