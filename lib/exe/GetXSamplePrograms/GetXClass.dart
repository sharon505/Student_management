import 'package:get/get.dart';


class GetXClass extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    add();
    super.onInit();
  }

  @override
  void onReady() {
    print('ready');
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    print('closed');
    super.onClose();
  }

  final RxInt num = 0.obs;

  add()=>num.value++;

  sub()=>num.value!=0? num.value-- : ();

}