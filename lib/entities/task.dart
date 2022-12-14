import 'package:isar/isar.dart';
part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String? title;
  String? category;
  bool? completed;
}