import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_management/Provider/UiProvidor.dart';
import '../Provider/GetXState.dart';
import '../Widgets/Widgets.dart';
import '../main.dart';
import 'StudentAddingPage.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchResult = Provider.of<HiveProvider>(context).searchResult;

    // final getProvider = getXController.searchResult;

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: searchBar(
        width: size.width / 7,
        textFieldWidth: size.width - 80,
        context: context,
      ),
      body: searchResult.isNotEmpty
          ? ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (BuildContext context, int index) {
                final user = searchResult[index];

                return studentTile(
                    emailSizedBox: size.width / 2,
                    textPreSpace: size.height / 100,
                    bottom: size.height / 95,
                    containerSize: size.height / 5.3,
                    fontSize: size.width / 20,
                    name: user.name,
                    bach: user.bach,
                    email: user.email,
                    gender: user.gender,
                    delete: () =>
                        context.read<HiveProvider>().deleteByIndex(index),
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
              })
          : Center(
              child: Text(
                "No User Found",
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
    );
  }
}

class SearchPageGetX extends StatelessWidget {
  const SearchPageGetX({super.key});

  @override
  Widget build(BuildContext context) {

    // final GetXStateHiveController controller = Get.put(GetXStateHiveController());

    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: searchBar(
          width: size.width / 7,
          textFieldWidth: size.width - 80,
          context: context,
        ),
        body: GetX<GetXStateHiveController>(
          builder: ( controller) {
            final searchResult = controller.searchResult;

            return searchResult.isNotEmpty
                ? ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (BuildContext context, int index) {
                final user = searchResult[index];

                return studentTile(
                  emailSizedBox: size.width / 2,
                  textPreSpace: size.height / 100,
                  bottom: size.height / 95,
                  containerSize: size.height / 5.3,
                  fontSize: size.width / 20,
                  name: user.name,
                  bach: user.bach,
                  email: user.email,
                  gender: user.gender,
                  // Delete action using the controller
                  delete: () => controller.deleteByIndex(index),
                  // Edit action, passing data to dialog
                  edit: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddStudentDialog(
                        gender: user.gender,
                        bach: user.bach,
                        email: user.email,
                        name: user.name,
                        edit: true, // Indicating edit mode
                        index: index,
                      );
                    },
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No User Found",
                style: TextStyle(color: AppColors.whiteColor),
              ),
            );
          },
        ));
  }
}
