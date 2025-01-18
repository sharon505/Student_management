import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_management/Provider/UiProvidor.dart';
import '../Hive/StudentModelClass.dart';
import '../Provider/GetXState.dart';
import '../Widgets/Widgets.dart';
import 'StudentAddingPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    void editAndAdd() => showDialog(
        context: context,
        builder: (BuildContext context) => const AddStudentDialog());

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBar(
            search: () => Navigator.pushNamed(context, 'SearchPage'),
            size: size.height / 20,
            iconSize: size.height / 25,
            padding: size.height / 70),
        floatingActionButton: Consumer<HiveProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return floatingActionButtonExtended(
                size: size.height / 60,
                padding: size.width / 20,
                onTap: () => editAndAdd());
          },
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Consumer<HiveProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return ValueListenableBuilder(
                  valueListenable: value.userBox.listenable(),
                  builder:
                      (BuildContext context, Box<StudentModelClass> box, _) {
                    if (box.isEmpty) {
                      return Align(
                        alignment: const Alignment(0.0, -0.2),
                        child: Text(
                          "No users added yet.",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: size.height / 50),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (BuildContext context, int index) {
                        final user = box.getAt(index)!;
                        return studentTile(
                            emailSizedBox: size.width / 2,
                            textPreSpace: size.height / 100,
                            bottom: size.height / 95,
                            containerSize: size.height / 5.3,
                            fontSize: size.width / 21,
                            name: user.name,
                            bach: user.bach,
                            email: user.email,
                            gender: user.gender,
                            delete: () => context
                                .read<HiveProvider>()
                                .deleteByIndex(index),
                            edit: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AddStudentDialog(
                                    gender: user.gender,
                                    bach: user.bach,
                                    email: user.email,
                                    name: user.name,
                                    edit: false,
                                    index: index,
                                  );
                                }));
                      },
                    );
                  },
                );
              },
            )));
  }
}


class GetXHomepage extends StatelessWidget {
  const GetXHomepage({super.key});

  @override
  Widget build(BuildContext context) {

    void editAndAdd() => showDialog(
      context: context,
      builder: (BuildContext context) => const AddStudentDialog(),
    );

    final Size size = MediaQuery.of(context).size;
    final hiveController = Get.put(GetXStateHiveController());


    return Scaffold(
      appBar: appBar(
        search: () => Get.toNamed('/SearchPage'),
        size: size.height / 20,
        iconSize: size.height / 25,
        padding: size.height / 70,
      ),
      floatingActionButton: floatingActionButtonExtended(
        size: size.height / 60,
        padding: size.width / 20,
        onTap: () => editAndAdd(),
      ),
      body: ValueListenableBuilder(
        valueListenable: hiveController.userBox.listenable(),
        builder:
            (BuildContext context, Box<StudentModelClass> box, _) {
          if (box.isEmpty) {
            return Align(
              alignment: const Alignment(0.0, -0.2),
              child: Text(
                "No users added yet.",
                style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: size.height / 50),
              ),
            );
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              final user = box.getAt(index)!;
              return studentTile(
                  emailSizedBox: size.width / 2,
                  textPreSpace: size.height / 100,
                  bottom: size.height / 95,
                  containerSize: size.height / 5.3,
                  fontSize: size.width / 21,
                  name: user.name,
                  bach: user.bach,
                  email: user.email,
                  gender: user.gender,

                  delete: () => hiveController.deleteByIndex(index),

                  edit: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddStudentDialog(
                          gender: user.gender,
                          bach: user.bach,
                          email: user.email,
                          name: user.name,
                          edit: false,
                          index: index,
                        );
                      }));
            },
          );
        },
      ),
    );
  }
}

