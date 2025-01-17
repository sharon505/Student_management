import 'package:hive_flutter/adapters.dart';
part 'StudentModelClass.g.dart';

@HiveType(typeId: 0)
class StudentModelClass extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String bach;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final bool gender;

  StudentModelClass({required this.name, required this.bach, required this.email, required this.gender});

}