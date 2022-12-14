import 'package:flutter/material.dart';
import '../../db_provider.dart';

class NewTaskWidget extends StatelessWidget {
  VoidCallback setStateCallback;
  String category;

  NewTaskWidget({super.key, required this.setStateCallback, required this.category});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build (BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(
                color: Colors.white
              ),
              decoration: InputDecoration(
                hintText: "Add a new task here...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400
                ),
                isDense: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 24, 24, 24),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 24, 24, 24),
                    width: 2.0
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 24, 24, 24),
                    width: 2.0
                  )
                ),
                suffixIcon: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    )
                  ),
                  onPressed: () async {
                    if (_controller.text.isNotEmpty) {
                      await DBProvider().createTask(_controller.text.toString(), category);
                      setStateCallback();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Text must not be empty")
                        )
                      );
                    }
                  },
                  label: const Text("Create"),
                  icon: const Icon(Icons.add_rounded),
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}