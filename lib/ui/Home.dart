import 'package:flutter/material.dart';
import 'TodoScreen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: TodoScreen(),
    );
  }
}
