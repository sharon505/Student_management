import 'package:flutter/material.dart';
import 'package:student_management/pages/HomePage.dart';

import 'Widgets/Widgets.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor
      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
