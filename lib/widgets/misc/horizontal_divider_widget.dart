import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 0.5,
      color: Colors.grey.shade800,
    );
  }
}