import 'package:isar/isar.dart';
import 'entities/task.dart';
import 'entities/category.dart';

class DBProvider {
  late Future<Isar> db;

  DBProvider() {
    db = openDB();
  }

  Future<Isar> openDB () async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(inspector: true, [TaskSchema, CategorySchema]);
    }
    return Future.value(Isar.getInstance());
  }

  Future<int> getCategoryCount () async {
    final isar = await db;
    int count = await isar.categorys.count();

    return count;
  }

  Future<Category?> getFirstCategory () async {
    final isar = await db;

    return await isar.categorys.where().findFirst();
  }

  Future<void> createTask (String title, String category) async {
    final isar = await db;
    final task = Task()..title=title..category=category..completed=false;

    await isar.writeTxn(() => isar.tasks.put(task));
  }

  Future<void> deleteTask (int id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.tasks.delete(id));
  }

  Future<List<Task>> getTasks (String category) async {
    final isar = await db;

    return isar.tasks.filter().categoryEqualTo(category).findAll();
  }

  Future<int> getCategoryTaskCount (String title) async {
    final isar = await db;

    return isar.tasks.filter().categoryEqualTo(title).count();
  }

  Future<void> createCategory (String title) async {
    final isar = await db;
    final category = Category()..title = title;

    await isar.writeTxn(() => isar.categorys.put(category));
  }

  Future<List<Category>> getCategories () async {
    final isar = await db;
    return isar.categorys.where().findAll();
  }

  Future<void> deleteCategory (int id, String title) async {
    final isar = await db;
    await isar.writeTxn(() => isar.tasks.filter().categoryEqualTo(title).deleteAll());
    await isar.writeTxn(() => isar.categorys.delete(id));
  }

  Future<bool> categoryExists (String title) async {
    final isar = await db;

    int count = await isar.categorys.filter().titleEqualTo(title).count();

    if (count < 1) {
      return false;
    }
    return true;
  }

  Future<void> updateCompleted (id, bool completed) async {
    final isar = await db;
    final task = await isar.tasks.get(id);

    task?.completed = completed;
    await isar.writeTxn(() => isar.tasks.put(task!));
  }
}