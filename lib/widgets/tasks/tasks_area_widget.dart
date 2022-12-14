import 'package:flutter/material.dart';
import '../../entities/category.dart';
import 'new_task_widget.dart';
import 'task_widget.dart';
import '../../db_provider.dart';

class TasksArea extends StatefulWidget {
  VoidCallback setMainState;
  String title = "";
  TasksArea({super.key, required this.setMainState, required this.title});

  @override
  State<StatefulWidget> createState () => _TasksAreaState();
}

class _TasksAreaState extends State<TasksArea> {

  @override
  Widget build (BuildContext context) { 
    return Expanded(
      child: widget.title.isEmpty ? const Center(
          child: Text(
            "Select a category",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0
            ),
          ),
        ) : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 24, 24),
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  child: Text(
                    widget.title.isEmpty ? "No Cat" : widget.title, 
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            NewTaskWidget(setStateCallback: updateTaskList, category: widget.title),
            Expanded(
              child: FutureBuilder(
                future: DBProvider().getTasks(widget.title),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) => TaskWidget(
                        id: snapshot.data![index].id,
                        complete: snapshot.data![index].completed!,
                        title: snapshot.data![index].title!,
                        setStateCallback: updateTaskList,
                      )
                    );
                  } else if (snapshot.hasError) {
                    return const Text("There was an error");
                  }
                  return const CircularProgressIndicator();
                }
              )
            )
          ],
        ),
      ),
    );
  }

  void updateTaskList () async {
    setState(() {});
    widget.setMainState();
  }
}