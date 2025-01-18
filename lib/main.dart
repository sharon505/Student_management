import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:student_management/pages/HomePage.dart';
import 'package:student_management/pages/SearchPage.dart';
import 'Hive/StudentModelClass.dart';
import 'Provider/UiProvidor.dart';
import 'Widgets/Widgets.dart';

List<SingleChildWidget> providers=[
  ChangeNotifierProvider(create: (context)=>UiProvider()),
  ChangeNotifierProvider(create: (context)=>HiveProvider())
];

bool stateManagement = false;

void main()async{
  await Hive.initFlutter();
  Hive.registerAdapter(StudentModelClassAdapter());
  await Hive.openBox<StudentModelClass>('userBox');
  stateManagement? runApp(MultiProvider(providers: providers,child: const MyApp())) :
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    stateManagement? print('Provider_____________________________________________________________________________________________') :
    print('GetX___________________________________________________________________________________________________________________');
    return stateManagement? MaterialApp(
      routes: {
        'SearchPage':(context)=>const SearchPage()
      },
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    ) : GetMaterialApp(
      getPages: [
        GetPage(name: '/SearchPage', page: ()=>const SearchPageGetX())
      ],
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldColor
      ),
      debugShowCheckedModeBanner: false,
      home: stateManagement? const Homepage() :  const GetXHomepage(),
    );
  }
}
