import 'package:flutter/material.dart';
import '../Widgets/Widgets.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        floatingActionButton: floatingActionButtonExtended(),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return studentTile();
            },
          ),
        ));
  }
}
