import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../Hive/StudentModelClass.dart';


class GetXStateUIController extends GetxController {
  // Gender Selection
  RxString selectedValue = "Male".obs;

  // Change Gender Value
  void changeValue({required String value}) {
    selectedValue.value = value;
  }

  // Determine if the selected gender is not Male
  bool gender() {
    return selectedValue.value != 'Male';
  }
}

// class GetXStateHiveController extends GetxController {
//   // Hive Box to store StudentModelClass
//   final Box<StudentModelClass> userBox = Hive.box<StudentModelClass>('userBox');
//
//   // Reactive search result list
//   RxList<StudentModelClass> _searchResult = <StudentModelClass>[].obs;
//   // Getter for search result
//   List<StudentModelClass> get searchResult => _searchResult;
//
//   // Delete student by index
//   void deleteByIndex(int index) {
//     userBox.deleteAt(index);
//     _updateSearchResult(); // Ensure the search result reflects the change
//   }
//
//   // Edit student by index
//   void editByIndex(int index, StudentModelClass updatedStudent) {
//     userBox.putAt(index, updatedStudent);
//     _updateSearchResult(); // Update the result after editing
//   }
//
//   // Search students by name
//   void searchByName(String? query) {
//     if (query == null || query.isEmpty) {
//       _searchResult.assignAll(userBox.values.toList()); // All students
//     } else {
//       _searchResult.assignAll(userBox.values
//           .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
//           .toList());
//     }
//   }
//
//   // Update the reactive list based on the current userBox values
//   void _updateSearchResult() {
//     _searchResult.assignAll(userBox.values.toList());
//   }
// }



class GetXStateHiveController extends GetxController {
  final Box<StudentModelClass> userBox = Hive.box<StudentModelClass>('userBox');

  void deleteByIndex(int index) {
    userBox.deleteAt(index);
  }

  void editByIndex(int index, StudentModelClass updatedStudent) {
    userBox.putAt(index, updatedStudent);
  }

  // Reactive search result list
  RxList<StudentModelClass> _searchResult = <StudentModelClass>[].obs;

  // Getter for searchResult
  RxList<StudentModelClass> get searchResult => _searchResult;

  // Search students by name
  void searchByName(String? query) {
    if (query == null || query.isEmpty) {
      // Update search result with all students
      _searchResult.assignAll(userBox.values.toList());
    } else {
      // Filter and update the search result
      _searchResult.assignAll(
        userBox.values
            .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }
}
