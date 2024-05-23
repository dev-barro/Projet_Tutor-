import 'package:flutter/material.dart';


class CircularProgressIndicatorDemo extends StatelessWidget {
  const CircularProgressIndicatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          // Default CircularProgressIndicator
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          // CircularProgressIndicator with specific color
          const CircularProgressIndicator(
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          // CircularProgressIndicator with specific stroke width
          const CircularProgressIndicator(
            strokeWidth: 8.0,
          ),
          const SizedBox(height: 20),
          // CircularProgressIndicator with specific size
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: const CircularProgressIndicator(),
          ),
          const SizedBox(height: 20),
          // CircularProgressIndicator with a value
          const CircularProgressIndicator(
            value: 0.7,
          ),
          const SizedBox(height: 20),
          // CircularProgressIndicator with background color and progress color
          const CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
