import 'package:crossptodo/db_provider.dart';
import 'package:crossptodo/widgets/categories/category_sidebar_widget.dart';
import 'package:crossptodo/widgets/misc/horizontal_divider_widget.dart';
import 'package:crossptodo/widgets/tasks/tasks_area_widget.dart';
import 'package:flutter/material.dart';

import 'entities/category.dart';

void main () {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});
  @override
  Widget build (BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState () => _HomeState();
}

class _HomeState extends State<Home> {

  int catCount = 0;
  String pageTitle = "";

  @override
  void initState() {
    super.initState();
    updateCatCount();
  }

  Future<void> updateCatCount () async {
    catCount = await DBProvider().getCategoryCount();
    print(catCount);
  }

  @override
  Widget build (BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 44, 44, 44),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategorySideBar(contxt: context, updateStateCallback: updateMainStateCB, pageTitleMethod: sendTitle),
            HorizontalDivider(),
            FutureBuilder(
              future: DBProvider().getCategoryCount(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 0) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          "Create a category to create a task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0
                          ),
                        ),
                      )
                    );
                  }
                  return TasksArea(setMainState: updateMainStateCB, title: pageTitle);
                } else if (snapshot.hasError) {
                  return  const Text("ERROR");
                }
                return const CircularProgressIndicator();
              }
            )
          ],
        )
      )
    );
  }

  void sendTitle (String title) {
    setState(() {
      pageTitle = title;
    });
  }

  void updateMainStateCB () {
    setState(() {});
  }
}