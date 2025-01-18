import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier{

  int _num = 0;
  int get num => _num;

  int _value = 0;
  int get value => _value;

  List<int>_numbers=[];
  List<int> get numbers=> _numbers;

  void add(){
    _num++;
    _numbers.add(_num);
    notifyListeners();
  }

  void minus(){
    _num!=0? _num-- + _numbers.removeLast() : null;
    notifyListeners();
  }

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  void startTimer() {
    _isRunning = true;
    timer();
  }

  void stopTimer() {
    _isRunning = false;
  }

  Future<void>timer()async{
    if (!_isRunning) return;
    await Future.delayed(const Duration(seconds: 1),()=>add());
    timer();
    notifyListeners();
  }

  void navBar({required int value}){
    _value = value;
    notifyListeners();
  }

}