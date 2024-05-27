import 'package:application/BackgroundImageWidget.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const BackgroundImageWidget(
      child: Center(
        child: Text("Contacts Page", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
