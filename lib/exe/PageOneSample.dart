import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'Provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => NumberProvider())
];

List<Widget> bottomPages = const [Counter(), ExampleTwo(), ExampleThree()];

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: const BottomNavigationBarProvider(),
  ));
}

class BottomNavigationBarProvider extends StatelessWidget {
  const BottomNavigationBarProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Consumer<NumberProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return bottomPages[value.value];
        },
      ), bottomNavigationBar: Consumer<NumberProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return BottomNavigationBar(
              currentIndex: value.value,
              onTap: (value) =>
                  context.read<NumberProvider>().navBar(value: value),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: 'example1'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_alarm), label: 'example2'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_time_filled), label: 'example3'),
              ]);
        },
      )),
    );
  }
}

class ExampleTwo extends StatelessWidget {
  const ExampleTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<NumberProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.numbers.isEmpty) {
          return const Center(child: Text("not Added"));
        }
        return ListView.builder(
          itemCount: value.numbers.length,
          itemBuilder: (BuildContext context, int index) {
            String data = value.numbers[index].toString();
            return ListTile(
              title: Text(data),
            );
          },
        );
      },
    ));
  }
}

class ExampleThree extends StatelessWidget {
  const ExampleThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.play_arrow_outlined),
            onPressed: ()=>context.read<NumberProvider>().startTimer()
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.pause),
              onPressed: ()=>context.read<NumberProvider>().stopTimer()
          ),
        ],
      ),
      body: Consumer<NumberProvider>(
      builder: (BuildContext context, value, Widget? child) {
        final data = value.num.toString();
        return Center(
          child: Text(data),
        );
      },
    ));
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    // final num = context.watch<NumberProvider>();
    print("object");
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<NumberProvider>().add(),
            // onPressed: () => num.add(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<NumberProvider>().minus(),
            // onPressed: () => num.minus(),
            child: const Icon(Icons.minimize),
          ),
        ],
      ),
      body: Center(
        child: Consumer<NumberProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return Text(
                style: const TextStyle(fontSize: 20), value.num.toString());
          },
        ),
        // child: Text(
        //   // context.watch<NumberProvider>().num.toString(),
        //   num.num.toString(),
        //   style: const TextStyle(fontSize: 20),
        // ),
      ),
    );
  }
}
