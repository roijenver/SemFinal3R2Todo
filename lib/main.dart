import 'package:flutter/material.dart';
import 'package:untitled/page_one.dart';

void main() {

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageOne()
  ));
}
