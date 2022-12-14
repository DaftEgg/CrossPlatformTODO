import 'package:flutter/material.dart';
import '../../db_provider.dart';

class TaskWidget extends StatefulWidget {
  int id;
  bool complete;
  String title;
  VoidCallback setStateCallback;

  TaskWidget({super.key, required this.id, required this.complete, required this.title, required this.setStateCallback});

  @override
  State<StatefulWidget> createState () => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 29, 29, 29),
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: ListTile(
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              decoration: widget.complete == true ? TextDecoration.lineThrough : TextDecoration.none
            ),
          ),
          leading: Checkbox(
            value: widget.complete,
            shape: CircleBorder(),
            checkColor: Colors.white,  // color of tick Mark
            activeColor: Colors.red,
            onChanged: (bool? value) async {
              await DBProvider().updateCompleted(widget.id, value!);
              widget.setStateCallback();
            }
          ),
          trailing: IconButton(
            onPressed: () async {
              await DBProvider().deleteTask(widget.id);
              widget.setStateCallback();
            },
            icon: Icon(Icons.delete_rounded, color: Colors.grey.shade400),
          ),
        )
      )
    );
  }
}