import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_management/Provider/UiProvidor.dart';
import '../Hive/StudentModelClass.dart';
import '../Provider/GetXState.dart';
import '../Widgets/Widgets.dart';
import '../main.dart';

class AddStudentDialog extends StatelessWidget {
  final String? name;
  final String? bach;
  final String? email;
  final bool? gender;
  final bool? edit;
  final int? index;

  const AddStudentDialog(
      {super.key, this.name, this.bach, this.email, this.gender, this.edit, this.index});

  @override
  Widget build(BuildContext context) {

    final hiveController = Get.put(GetXStateUIController());
    final hiveControllerHive = Get.put(GetXStateHiveController());

    TextEditingController? controllerName =
        TextEditingController(text: name ?? '');
    TextEditingController? controllerEmail =
        TextEditingController(text: email ?? '');
    TextEditingController? controllerBach =
        TextEditingController(text: bach ?? '');

    final formKey = GlobalKey<FormState>();
    final List<String> dropdownItems = [
      "Female",
      "Male",
    ];

    final Box<StudentModelClass> userBox =
        Hive.box<StudentModelClass>('userBox');

    void addStudent() {
      userBox.add(StudentModelClass(
          name: controllerName.text ?? "",
          bach: 'BCB${controllerBach.text}' ?? '',
          email: controllerEmail.text ?? '',
          gender: stateManagement? context.read<UiProvider>().gender() :
          hiveController.gender()));
      Navigator.pop(context);
      controllerName.clear();
      controllerBach.clear();
      controllerEmail.clear();
    }

    void editStudent({int? index}) {
      stateManagement?
      context.read<HiveProvider>().editByIndex(
          index!,
          StudentModelClass(
              name: controllerName.text ?? "",
              bach: controllerBach.text.toUpperCase() ?? '',
              email: controllerEmail.text ?? '',
              gender: context.read<UiProvider>().gender()
          )
      ) : hiveControllerHive.editByIndex(
          index!,
          StudentModelClass(
              name: controllerName.text ?? "",
              bach: controllerBach.text.toUpperCase() ?? '',
              email: controllerEmail.text ?? '',
              gender: hiveController.gender()
          )
      );
      Navigator.pop(context);
    }

    return AlertDialog(
      backgroundColor: Colors.grey[900], // Replace with AppColors.scaffoldColor
      title: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controllerName,
              decoration: const InputDecoration(
                label: Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white), // Replace with AppColors.whiteColor
                ),
              ),
              style: const TextStyle(color: Colors.white),
              // Replace with AppColors.whiteColor
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controllerBach,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                label: Text(
                  'Batch',
                  style: TextStyle(
                      color: Colors.white), // Replace with AppColors.whiteColor
                ),
              ),
              style: const TextStyle(color: Colors.white),
              // Replace with AppColors.whiteColor
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a batch';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controllerEmail,
              decoration: const InputDecoration(
                label: Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.white), // Replace with AppColors.whiteColor
                ),
              ),
              style: const TextStyle(color: Colors.white),
              // Replace with AppColors.whiteColor
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                stateManagement?
                Consumer<UiProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return DropdownButton<String>(
                        dropdownColor: Colors.grey[800],
                        iconEnabledColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        value: value.selectedValue,
                        items: dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) => context
                            .read<UiProvider>()
                            .changeValue(value: newValue!));
                  },
                ) : GetX<GetXStateUIController>(builder: (controller) {
                  return DropdownButton<String>(
                      dropdownColor: Colors.grey[800],
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      value: controller.selectedValue.toString(),
                      items: dropdownItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) => controller.changeValue(value: newValue!));
                },),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    floatingActionButtonExtended(
                      text: "Exit",
                      size: 13,
                      padding: 8,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    floatingActionButtonExtended(
                      text:  "Save" ,
                      size: 13,
                      padding: 8,
                      onTap: () {
                        if (formKey.currentState?.validate() ?? false) {
                          // If the form is valid, do something
                          edit ?? !false ? addStudent() : editStudent(index: index);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Form is valid!')),
                          // );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
