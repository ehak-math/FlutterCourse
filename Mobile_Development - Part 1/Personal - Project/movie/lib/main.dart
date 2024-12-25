
import 'package:flutter/material.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {

  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
    
  }
}