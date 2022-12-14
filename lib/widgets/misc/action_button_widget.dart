import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  String title;
  IconData icon;

  ActionButton({super.key, required this.title, required this.icon});

  @override
  Widget build (BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color.fromARGB(255, 24, 24, 24),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: const Color.fromARGB(255, 24, 24, 24),
        leading: Icon(icon, color: Colors.red.shade600),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),
        ),
      )
    );
  }
}