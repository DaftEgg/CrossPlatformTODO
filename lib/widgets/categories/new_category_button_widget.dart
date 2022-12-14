import 'package:flutter/material.dart';

class CategoryButtonWidget extends StatelessWidget {
  VoidCallback openNewDialogCallback;
  String title;
  IconData icon;

  CategoryButtonWidget({super.key, required this.openNewDialogCallback, required this.title, required this.icon});

  @override
  Widget build (BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: const Color.fromARGB(255, 24, 24, 24),
      child: ListTile(
        onTap: () => openNewDialogCallback(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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