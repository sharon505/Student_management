import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/Provider/UiProvidor.dart';
import 'package:student_management/exe/PageOneSample.dart';

class AppColors {
  static Color scaffoldColor = const Color(0xFF1C1530);
  static Color whiteColor = const Color(0xFFFFFFFF);

  static List<Color> colors = [
    Colors.blue,
    Colors.purple
    // Colors.purple.shade300,
    // Colors.deepPurpleAccent.shade200,
  ];
}

Widget studentTile({
  String? name,
  String? bach,
  String? email,
  bool? gender,
  double? bottom,
  double? containerSize,
  double? textPreSpace,
  double? emailSizedBox,
  double? fontSize,
  Function()? edit,
  Function()? delete,
}) {

  final TextStyle textStyle = TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: fontSize ??  18,
  );

  containerSize = containerSize ?? 160;

  return Container(
    margin: EdgeInsets.only(bottom: bottom?? 10),
    decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Colors.transparent,
          Colors.purple,
        ]),
        borderRadius: BorderRadius.circular(10)),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: containerSize,
                width: containerSize,
                child: Image(
                    image:  gender ?? false ?
                    const AssetImage('Assets/girl-removebg-preview.png') :
                    const AssetImage('Assets/boy-removebg-preview.png')
                )
            ),
            // const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: textPreSpace ?? 20,),
                Text(name ?? "name",
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(bach ?? "bach",
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: emailSizedBox ?? 200,
                  child: Text(email ?? "name@Gmail.com",
                    style: textStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GradientIconButton(
                  padding: 10,
                  iconSize: 18,
                  borderRadius: 10,
                  icon: Icons.edit,
                  gradientColors: AppColors.colors,
                  onPressed: edit ?? ()=>print('edit'),
                ),
                const SizedBox(width: 10),
                GradientIconButton(
                  padding: 10,
                  iconSize: 18,
                  borderRadius: 10,
                  icon: Icons.delete,
                  gradientColors: AppColors.colors,
                  onPressed: delete ?? ()=>print('delete'),
                ),
              ],
            ),
          ),
        )
      ],
    )
  );
}

class GradientIconButton extends StatelessWidget {

  final IconData icon;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final double? padding;
  final double? iconSize;
  final double? borderRadius;

  GradientIconButton({
    required this.icon,
    required this.onPressed,
    required this.gradientColors, this.padding, this.iconSize, this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all( padding ?? 10),
      decoration: BoxDecoration(
        borderRadius: borderRadius!=null?
        BorderRadius.circular(borderRadius!) : null,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: borderRadius==null? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Center(
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize ??  30.0,
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget searchBar({
  required BuildContext context,
  double? width,
  double? textFieldWidth,
}){
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            SizedBox(
              width: textFieldWidth ??  320,
              child: TextField(
                style: TextStyle(
                  color: AppColors.whiteColor
                ),
                onChanged: (value)=>context.read<HiveProvider>().searchByName(value),
                decoration: InputDecoration(
                  label: Text("Search",style: TextStyle(color: AppColors.whiteColor),),
                  prefixIcon: Icon(Icons.search,color: AppColors.whiteColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: width ?? 60,
              height: width ?? 60,
              child: GradientIconButton(
                icon: Icons.person_search,
                onPressed: ()=>Navigator.pop(context),
                gradientColors: AppColors.colors,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

PreferredSizeWidget appBar({
  Function()? search,
  double? size,
  double? padding,
  double? iconSize

}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    // colors: AppColors.colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size ??  40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size ?? 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GradientIconButton(
                padding: padding,
                iconSize: iconSize,
                icon: Icons.person_search,
                onPressed: search ?? ()=>print("Search"),
                gradientColors: AppColors.colors,
              )
            ],
          ),
        ),
      ));
}

Widget floatingActionButtonExtended({
  Function()? onTap,
  String? text,
  double? size,
  double? padding,
  double? bottomPadding,
}) {
  return InkWell(
    onTap: onTap ?? ()=>print('floatAction Button'),
    child: Container(
      margin: EdgeInsets.only(bottom: bottomPadding ?? 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
              colors: AppColors.colors)),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 15),
        child: Text(
          text ?? "Add Student",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            fontSize: size ?? null
          ),
        ),
      ),
    ),
  );
}
