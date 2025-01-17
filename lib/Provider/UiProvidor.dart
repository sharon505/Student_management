import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/adapters.dart';
import '../Hive/StudentModelClass.dart';


class HiveProvider extends ChangeNotifier{

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool _isFabVisible = true;
  bool get isFabVisible => _isFabVisible;

  HiveProvider() {
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isFabVisible) {
        _isFabVisible = false;
        notifyListeners();
      }
    } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_isFabVisible) {
        _isFabVisible = true;
        notifyListeners();
      }
    }
  }

  final Box<StudentModelClass> userBox = Hive.box<StudentModelClass>('userBox');

  void deleteByIndex(int index) {
    userBox.deleteAt(index);
    notifyListeners();
  }

  void editByIndex(int index, StudentModelClass updatedStudent) {
    userBox.putAt(index, updatedStudent);
    notifyListeners();
  }

  List<StudentModelClass> _searchResult = [];
  List<StudentModelClass> get searchResult => _searchResult;

  void searchByName(String? query) {
    if (query == null || query.isEmpty) {
      _searchResult = userBox.values.toList(); // Return all students if query is empty
    } else {
      _searchResult = userBox.values
          .where((student) => student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners about the updated search result
  }

}

UiProvider uiProvider = UiProvider();

class UiProvider extends ChangeNotifier{



  String _selectedValue = "Male";
  String get selectedValue => _selectedValue;

  void changeValue({required String value}){
    _selectedValue = value;
    notifyListeners();
  }

  bool gender() {
    notifyListeners();
    if (_selectedValue != 'Male') {
      return true;
    } else {
      return false;
    }
  }
}