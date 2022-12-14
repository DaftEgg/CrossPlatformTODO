import 'package:flutter/material.dart';

class CategoryDivider extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey.shade800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              "Categories",
              style: TextStyle(
                color: Colors.grey.shade400
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 0.5,
              color: Colors.grey.shade800,
            ),
          )
        ],
      ),
    );
  }
}