import 'package:flutter/material.dart';
import 'package:todoapp_crudcrud_api/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App w/Crud Crud API',
      home: HomeScreen(),
    );
  }
}