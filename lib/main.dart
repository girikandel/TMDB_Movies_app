import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/constants/colors.dart';
import 'package:movieapp/route/routes.dart';
import 'package:movieapp/screens/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: MyColors.backgroundColor,
        useMaterial3: true,
      ),
      getPages: MeroRoutes.routes,
      home: const HomePage(),
    );
  }
}
