import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'GetXClass.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavGetX(),
    );
  }
}

List<Widget> pagesGetX = const [PageOne(), PageTwo(), PageThree()];

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final GetXClass controller = Get.put(GetXClass());
    print("object");
    return Scaffold(
        appBar: AppBar(
          title: const Text('seperated class'),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
                onPressed: () => controller.add(),
                child: const Icon(Icons.add)),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
                onPressed: () => controller.sub(),
                child: const Icon(Icons.minimize)),
          ],
        ),
        body: GetX<GetXClass>(
          builder: (controller) {
            return Center(
              child: Text(controller.num.toString()),
            );
          },
        )
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    print('object');
    RxInt num = 0.obs;
    TextStyle style = const TextStyle(fontSize: 30);
    return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () => num.value++,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () => num.value != 0 ? num.value-- : (),
              child: const Icon(Icons.minimize),
            ),
          ],
        ),
        body: Obx(
          () => Center(
            child: Text(
              num.value.toString(),
              style: style,
            ),
          ),
        ));
  }
}

class BottomNavGetX extends StatelessWidget {
  const BottomNavGetX({super.key});

  @override
  Widget build(BuildContext context) {
    final index = RxInt(0);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: index.value,
            onTap: (val) => index.value = val,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "page1"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "page2"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "page3"),
            ]),
      ),
      body: Obx(() => pagesGetX[index.value]),
    );
  }
}

TextEditingController controller = TextEditingController();

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    //print("object????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????");
    RxString text = 'cat'.obs;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => text.value = controller.text,
        child: const Icon(Icons.add),
      ),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(controller: controller),
            ),
          )),
      body: Center(
        child: Obx(() => Text(text.value.toString())),
      ),
    );
  }
}
