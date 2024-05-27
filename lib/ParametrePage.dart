import 'package:application/BackgroundImageWidget.dart';
import 'package:flutter/material.dart';

class ParametrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Center(
        child: Text("Parametre Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}