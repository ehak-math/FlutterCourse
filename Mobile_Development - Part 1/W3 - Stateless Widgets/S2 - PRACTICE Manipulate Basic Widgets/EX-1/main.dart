import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp( 
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Exercise1"),
        ),
        body: const Center(
          child: Text("Hello my name is Ehak!",
          style: TextStyle(color: Colors.orange, fontSize: 25), ),
        ),
      )
    ),
  );
}
