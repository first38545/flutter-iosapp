import 'package:hive/hive.dart';

part 'my_model.g.dart';

@HiveType(typeId: 0)
class MyModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late List<Item> items;

  MyModel({required this.name, required this.items});
}

@HiveType(typeId: 1)
class Item {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String imagePath;

  Item({required this.name, required this.imagePath});
}